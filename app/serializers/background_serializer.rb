class BackgroundSerializer
  include FastJsonapi::ObjectSerializer

  set_type 'background'
  link :url
end
