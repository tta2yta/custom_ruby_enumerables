module Enumerable
    def my_each
        if block_given?
            i=0
            while i < self.size
                yield self[i]
                i += 1
            end
        else
            yield self
        end
    end
end