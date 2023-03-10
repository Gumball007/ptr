defmodule Project0.Week5.Task2 do

    HTTPoison.start()
  
    def get_quotes() do
      response = HTTPoison.get!("https://quotes.toscrape.com")

      html = response.body
      doc = Floki.parse_document!(html)

      quotes = doc
      |> Floki.find(".text")
      |> Floki.text(sep: "%")
      |> String.split("%")

      authors = doc
      |> Floki.find(".author")
      |> Floki.text(sep: "%")
      |> String.split("%")

      tags = doc
      |> Floki.find("meta.keywords")
      |> Floki.attribute("content")
      
       Enum.zip([quotes, authors, tags])
       |> Enum.map(fn {quotes, author, tags} ->
        %{
            quote: quotes,
            author: author,
            tags: tags
        }
        end)
        |> IO.inspect

    end

    def run() do
        quotes = get_quotes()
        IO.inspect quotes
    end
end

Project0.Week5.Task2.get_quotes()