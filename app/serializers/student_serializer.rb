class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :dob, :gender
end