class User < ApplicationRecord
    has_one :car
    has_one :bike
end
