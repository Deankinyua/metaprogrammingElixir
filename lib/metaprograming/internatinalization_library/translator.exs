defmodule Translator do
  defmacro __using__(_options) do
    quote do
      Module.register_attribute(__MODULE__, :locales,
        accumulate: true,
        persist: false
      )

      # use this to accumulate the locales using the locale macro that is present in translator module

      import unquote(__MODULE__), only: [locale: 2]
      # Elixir allows us to set a special module attribute, @before_compile, to notify the
      # compiler that an extra step is required just before compilation is finished.
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(env) do
    # before_compile marks the last step just before we finish code generation
    compile(Module.get_attribute(env.module, :locales))
  end

  defmacro locale(name, mappings) do
    quote bind_quoted: [name: name, mappings: mappings] do
      @locales {name, mappings}
    end
  end

  def compile(translations) do
    translations_ast =
      for {locale, mappings} <- translations do
        deftranslations(locale, "", mappings)
      end

    final_ast =
      quote do
        def t(locale, path, bindings \\ [])
        unquote(translations_ast)
        def t(_locale, _path, _bindings), do: {:error, :no_translation}
      end

    IO.puts(Macro.to_string(final_ast))
    final_ast
  end

  defp deftranslations(locale, current_path, mappings) do
    # deftranslations("en", "", mappings)
    # TBD: Return an AST of the t/3 function defs for the given locale

    # * example of a mapping
    # * flash: [hello: "Hello %{first} %{last}!", bye: "Bye, %{name}!"],
    # * users: [title: "Users"]

    for {key, val} <- mappings do
      # e.g path = append_path("", flash) -> "flash"
      # val = [hello: "Hello %{first} %{last}!", bye: "Bye, %{name}!"],
      # val = "Hello %{first} %{last}!"
      path = append_path(current_path, key)
      # append_path("flash", hello) -> "flash.hello"

      if Keyword.keyword?(val) do
        # deftranslations("en", "flash", [hello: "hello", bye: "bye"])
        deftranslations(locale, path, val)
      else
        quote do
          # t("en", "flash.hello", bindings)
          def t(unquote(locale), unquote(path), bindings) do
            unquote(interpolate(val))
          end
        end
      end
    end
  end

  defp interpolate(string) do
    ~r/(?<head>)%{[^}]+}(?<tail>)/
    |> Regex.split(string, on: [:head, :tail])
    |> Enum.reduce("", fn
      <<"%{" <> rest>>, acc ->
        20
        key = String.to_atom(String.rstrip(rest, ?}))

        quote do
          unquote(acc) <> to_string(Dict.fetch!(bindings, unquote(key)))
        end

      segment, acc ->
        quote do: unquote(acc) <> unquote(segment)
    end)
  end

  # defp interpolate(string) do
  #   # TBD interpolate bindings within string-
  #   string
  # end

  defp append_path("", next), do: to_string(next)
  defp append_path(current, next), do: "#{current}.#{next}"
end
