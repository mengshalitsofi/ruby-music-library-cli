module Persistable
    module InstanceMethods
        def save 
            self.class.all << self
        end
    end

    module ClassMethods

        def destroy_all
            self.all.clear
        end

        def scount
            self.all.size
        end
    end
end