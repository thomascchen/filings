class BaseSerializer
  include JSONAPI::Serializer

  set_key_transform :dash
end
