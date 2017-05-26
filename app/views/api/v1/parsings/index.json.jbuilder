json.set! :current_page, @parsings.current_page
json.set! :total_pages, @parsings.total_pages
json.set! :total_count, @parsings.total_count
json.set! :per_page_count, @parsings.size

json.set! :parsings do
  json.array!(
    @parsings,
    partial: 'api/v1/parsings/parsing',
    as: :parsing
  )
end
