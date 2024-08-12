defmodule Mod do
  defmacro definfo do
    # dbg(__ENV__)
    # * Returns the Macro's definition context
    IO.puts("In macro's context (#{__MODULE__}).")
    # * Some additional information about the definition context
    # IO.puts("""
    # Definition context of the macro is #{__MODULE__}
    # The macros in definition are #{inspect(__MODULE__.__info__(:macros))}
    # """)

    quote do
      # * We are now inside the caller context
      IO.puts("In caller's context (#{__MODULE__}).")

      def friendly_info do
        IO.puts("""
        My name is #{__MODULE__}
        My functions are #{inspect(__MODULE__.__info__(:functions))}
        """)
      end
    end
  end
end

defmodule MyModule do
  require Mod
  Mod.definfo()
end

# ast =(
#   quote do
#     if meaning_to_life == 42 do
#       "it's true"
#     else
#       "it remains to be seen"
#     end
#   end)
