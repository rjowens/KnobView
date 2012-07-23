class MathHelper
  def self.radians(angle)
    angle/180 * Math::PI
  end
  
  def self.dot(a,b)
    a[0]*b[0] + a[1]*b[1]
  end
  
  def self.cross(a,b)
    [0,a[0]*b[1]-b[0]*a[1]]
  end
  
  def self.length(v)
    Math::sqrt(v[0]*v[0] + v[1]*v[1])
  end
  
  def self.angle(a,b)
    Math::atan(length(cross(a,b)) / dot(a,b))
  end
end