module Enumerable
    def my_each
        #Clone of "each" enumerator method
        for k in self do
            yield k
        end
    end
    
    def my_each_with_index
        #Clone of "each_with_index" enumerator method
        return self unless block_given?

        v = 0
        for k in self do
            yield k, v
            v += 1
        end
    end

    def my_select
        #Clone of "select" enumerator method
        return self unless block_given?

        select_array = Array.new
        self.my_each { |k| select_array << k if yield k }
        return select_array
    end

    def my_all?(argv=nil)
        #Clone of "all?" enumerator method
        truth_value = true
        if !argv.nil?
            self.my_each { |element| truth_value = false unless argv === element }
            return truth_value
        end
        if block_given?
            self.my_each { |k|
                truth_value = false unless yield k
            }
        else
            self.my_each { |element|
            truth_value = false unless !!element}
        end
        return truth_value
    end

    def my_any?(argv=nil)
        #Clone of "any?" enumerator method
        truth_value = false
        if !argv.nil?
            self.my_each { |element| truth_value = true if argv === element}
            return truth_value
        end
        if block_given?
            self.my_each { |k| 
                truth_value = true if yield k}
        else
            self.my_each { |element|
                truth_value = true if !!element}
        end
        return truth_value
    end

    def my_none?
        #Clone of "none?" enumerator method
        truth_value = true
        if !argv.nil?
            self.my_each { |element| truth_value = false if argv === element }
        end
        if block_given?
            self.my_each{ |k| 
                p k
                truth_value = false if yield k}
        else
            self.my_each{ |element|
                truth_value = false if !!element}
        end
        return truth_value
    end

    def my_count(argv=nil)
        #Clone of "count" enumerator method
        count = 0
        if !argv.nil?
            self.my_each { |element| count += 1 if element.eql? argv}
            return count
        end
        if block_given?
            self.my_each{ |k| count += 1 if yield k}
            return count
        else
            return self.size
            return count
        end
    end

    def my_map(proc_given=nil)
        my_array = Array.new
        if proc_given
            self.my_each {|k| my_array.push(proc_given.call(k))}
            return my_array
        end
            self.my_each{ |k| my_array.push(yield k)}
    end

    def my_inject(accumulator=nil, &block)
        p accumulator.class == Symbol
        self.class == Range ? arr = self.to_a : arr = self
        if block_given?
          if accumulator.nil?
            accumulator = self.first
            for i in 0..arr.size-2
              accumulator = block.call(accumulator, arr[i+1])
            end
            end
        if accumulator.class == Symbol
            for i in 0..arr.size-1
                p accumulator
                p u.send(accumulator)
            end
        else
            p "teste2"
            for i in 0..arr.size-1
              accumulator = block.call(accumulator, arr[i])
            end
          end
        end
        accumulator
    end
end

