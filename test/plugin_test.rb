#module P
  module A
    def self.included(base)
      puts "#{self} included in #{base}"
      a = (a || 0) + 1
      #p ClassMethods.inspect
      base.extend ClassMethods
    end
    module ClassMethods
      @@att_a = 0
      def a
        @@att_a
      end
      def a=(val)
        @@att_a=val
      end
      #def a
      #  @@att_a
      #end
    end
  end

  module B
    @@att_b = 10
    def B.included(base)
      puts "#{self} included in #{base}"
      #b = (b || 0) + 1
      #base.extend ClassMethods
    end
  end

  module C
    @@att_c = 100
    def C.included(base)
      puts "#{self} included in #{base}"
      #@@attr_c = (@@attr_c || 0) + 1
      #base.extend ClassMethods
    end

  end
#end

class P
  include A
  include B
  include C
end
class Q
  include A
  include B
  include C
end
class R
  include A
  include B
  include C
end

#p A.a

p P.a
p Q.new.a
p R.new.a
#puts P.attr_b.inspect
#puts P.attr_c.inspect
