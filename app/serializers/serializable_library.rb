class SerializableLibrary < JSONAPI::Serializable::Resource
  type 'libraries'

  has_many :library_contents do
    data do
      @object.library_contents_by_order
    end

    link :related do

    end

    meta do
      { count: @object.library_contents.alive.count }
    end

    link :self do
    end

    meta do
      { featured: true }
    end
  end
end
