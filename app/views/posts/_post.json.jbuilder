json.extract! post, :id, :owner, :title, :body, :coordinate, :private, :created_at, :updated_at
json.url post_url(post, format: :json)
