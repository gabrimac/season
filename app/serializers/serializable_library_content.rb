class SerializableLibraryContent < JSONAPI::Serializable::Resource
  type 'library_contents'

  attributes :expires_at, :quality

  has_one :content do
    data do
      @object.content
    end
  end
end
