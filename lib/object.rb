def self.subclasses(direct = false)
  classes = []
  if direct
    ObjectSpace.each_object(Class) do |c|
      next unless c.superclass == self
      classes << c
    end
  else
    ObjectSpace.each_object(Class) do |c|
      next unless c.ancestors.include?(self) and (c != self)
      classes << c
    end
  end
  classes
end