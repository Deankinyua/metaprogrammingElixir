defmodule Mime do
  @external_resource mimes_path = Path.join([__DIR__, "mimes.txt"])

  for line <- File.stream!(mimes_path, [], :line) do
    [type, rest] = line |> String.split() |> Enum.map(&String.trim(&1))
    extensions = String.split(rest)

    def exts_from_type(unquote(type)), do: unquote(extensions)
    def type_from_ext(ext) when ext in unquote(extensions), do: unquote(type)
  end

  def exts_from_type(_type), do: []
  def type_from_ext(_ext), do: nil
  def valid_type?(type), do: exts_from_type(type) |> Enum.any?()
end

# "Dean kamanu kinyua"

# "hahahha jajajja  jsjjsjjsj kakka "
# ? Using Unquote Fragments to dynamically make function definitions at compile time

defmodule Fragments do
  for {name, val} <- [one: 1, two: 2, three: 3] do
    def unquote(name)(), do: unquote(val)
  end
end
