json.cache! ['v1', parsing], expires_in: 100.minutes do
  json.set! :parsing do
    json.extract! parsing,
                  :id,
                  :created_at,
                  :status,
                  :url

    json.set! :links do
      json.array! parsing.payloads.link, :content
    end

    json.set! :h1 do
      json.array! parsing.payloads.h1, :content
    end

    json.set! :h2 do
      json.array! parsing.payloads.h2, :content
    end

    json.set! :h3 do
      json.array! parsing.payloads.h3, :content
    end
  end
end
