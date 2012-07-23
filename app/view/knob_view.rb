class KnobView < UIView
  attr_accessor :delegate, :percentage
  
  attr_accessor :innerKnobFillColor, :innerKnobStrokeColor, :outerKnobFillColor, :outerKnobStrokeColor, :indicatorFillColor, :indicatorBackgroundColor 
  
  def initWithFrame(frame)
    super(frame)
    self.opaque = true
    self.backgroundColor = UIColor.colorWithRed(225.0/255.0, green:225.0/255.0, blue:216.0/255.0, alpha:1.0)
    @stop_angle = 0.5
    @angle_adjust = @stop_angle
    @target_adjust = @stop_angle
    @adjusting = false    
    @deltas = []    
    
    @innerKnobFillColor = UIColor.colorWithRed(203.0/255.0, green:204.0/255.0, blue:194.0/255.0, alpha:1.0)
    @innerKnobStrokeColor = UIColor.colorWithRed(233.0/255.0, green:235.0/255.0, blue:223.0/255.0, alpha:1.0)
    @outerKnobFillColor = UIColor.colorWithRed(166.0/255.0, green:166.0/255.0, blue:159.0/255.0, alpha:1.0)
    @outerKnobStrokeColor = UIColor.colorWithRed(133.0/255.0, green:133.0/255.0, blue:127.0/255.0, alpha:1.0)
    @indicatorFillColor = UIColor.colorWithRed(105.0/255, green:105.0/255, blue:100.0/255, alpha:1.0)
    @indicatorBackgroundColor = UIColor.colorWithRed(255.0/255, green:255.0/255, blue:245.0/255.0, alpha:1.0)
    
    self 
  end
    
  def drawRect(rect)
    context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, @indicatorBackgroundColor.CGColor)            
    CGContextSetStrokeColorWithColor(context, @indicatorFillColor.colorWithAlphaComponent(0.3).CGColor)
    path = UIBezierPath.bezierPath
    path.moveToPoint([rect[1][0]/2, rect[1][1]/2])
    path.addArcWithCenter([rect[1][0]/2, rect[1][1]/2], radius:rect[1][0]/2 - 1, startAngle:Math::PI/2 - @stop_angle, endAngle:Math::PI/2 + @stop_angle, clockwise:false)
    path.closePath()
    path.fill()
    path.stroke()

    CGContextSetFillColorWithColor(context, @indicatorFillColor.CGColor)            
    path = UIBezierPath.bezierPath
    path.moveToPoint([rect[1][0]/2, rect[1][1]/2])
    path.addArcWithCenter([rect[1][0]/2, rect[1][1]/2], radius:rect[1][0]/2 - 1, startAngle:Math::PI/2 + @angle_adjust, endAngle:Math::PI/2 + @stop_angle, clockwise:false)
    path.closePath()
    path.fill()

    CGContextSetShadowWithColor(context, [0,0], 0.0, UIColor.clearColor.CGColor)    
    CGContextSetStrokeColorWithColor(context, @innerKnobStrokeColor.CGColor)
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor)           
    padding = rect.size.width/12  
    padding = 8 if padding < 8
    rectangle = [[padding, padding],[rect.size.width - 2*padding, rect.size.width - 2*padding]];
    CGContextBeginPath(context)
    CGContextAddEllipseInRect(context, rectangle)
    CGContextDrawPath(context, KCGPathFill);
    
    drawKnob(context, rect)
    drawTick(context, rect)
      
    emptyCircleX = rect[1][0]/2 - 0.16 * rect.size.width * Math::sin(Math::PI/2 + @stop_angle) - padding/2
    emptyCircleY = 0.90 * rect[1][1]
    CGContextBeginPath(context)
    CGContextSetStrokeColorWithColor(context,  @indicatorFillColor.CGColor)
    CGContextSetFillColorWithColor(context,  @indicatorBackgroundColor.CGColor)
    CGContextAddEllipseInRect(context, [[emptyCircleX, emptyCircleY], [padding/2,padding/2]])
    CGContextDrawPath(context, KCGPathFillStroke);

    emptyCircleX = rect[1][0]/2 + 0.16 * rect.size.width * Math::sin(Math::PI/2 + @stop_angle)
    emptyCircleY = 0.90 * rect[1][1]
    CGContextBeginPath(context)
    CGContextSetStrokeColorWithColor(context,  @indicatorFillColor.CGColor)
    CGContextSetFillColorWithColor(context,  @indicatorFillColor.CGColor)
    CGContextAddEllipseInRect(context, [[emptyCircleX, emptyCircleY], [padding/2, padding/2]])
    CGContextDrawPath(context, KCGPathFillStroke);
    
  end

  def drawKnob(context, rect)
    # Outer Circle
    dialPadding = 0.15 * rect.size.width
    
    CGContextSetLineWidth(context, 1.0)
    CGContextSetStrokeColorWithColor(context, @outerKnobStrokeColor.CGColor)
    CGContextSetFillColorWithColor(context, @outerKnobFillColor.CGColor)    
    CGContextBeginPath(context)
    rectangle = [[dialPadding, dialPadding],[rect.size.width - 2*dialPadding, rect.size.width - 2*dialPadding]];
    CGContextAddEllipseInRect(context, rectangle)
    CGContextDrawPath(context, KCGPathFillStroke);
    
    # Inner Circle
    CGContextSetStrokeColorWithColor(context, @innerKnobStrokeColor.CGColor)
    CGContextSetFillColorWithColor(context, @innerKnobFillColor.CGColor)        
    rectangle = [[dialPadding + 4, dialPadding+ 4],[rect.size.width - 2*dialPadding - 8, rect.size.width - 2*dialPadding - 8]];
    CGContextBeginPath(context)
    CGContextAddEllipseInRect(context, rectangle)
    CGContextDrawPath(context, KCGPathFillStroke);
  end
  
  def drawTick(context, rect)
    startAngle = Math::PI/2 + @angle_adjust;

    tickY_start = rect[1][1]/2 + 0.28 * rect.size.width * Math::sin(startAngle)
    tickX_start = rect[1][0]/2 + 0.28 * rect.size.width * Math::cos(startAngle)

    width = rect.size.width/28
          
    CGContextSetLineWidth(context, 1.0)
    CGContextSetRGBFillColor(context, 133.0/255.0, 133.0/255.0, 127.0/255.0, 1.0)    
    rectangle = [[tickX_start - width/2, tickY_start - width/2],[width, width]];
    CGContextBeginPath(context)
    CGContextAddEllipseInRect(context, rectangle)
    CGContextDrawPath(context, KCGPathFill);

  end
  
  def touchesBegan(touches, withEvent:event)
    @currentTouch = touches.anyObject.locationInView(self)
  end

  def touchesMoved(touches, withEvent:event)
    delta_y = @currentTouch.y - touches.anyObject.locationInView(self).y
      
    p1 = [self.frame.size.width/2, self.frame.size.height/2]
    p2 = [@currentTouch.x, @currentTouch.y]
    p3 = [touches.anyObject.locationInView(self).x, touches.anyObject.locationInView(self).y]

    v0 = [0,10]    
    v1 = [p2[0]-p1[0],p2[1]-p1[1]]
    v2 = [p3[0]-p1[0],p3[1]-p1[1]]
    
    delta = MathHelper::angle(v1,v0) - MathHelper::angle(v2,v0) 
    delta = delta - Math::PI if delta > Math::PI / 2
    delta = delta + Math::PI if delta < -Math::PI / 2        
    
    if (p2[0] < p1[0])
      @deltas <<  -1 * delta
    else
      @deltas << delta
    end
        
    if !@adjusting
      @adjusting = true
      Dispatch::Queue.main.after 0.1 do
        adjust_knob
      end        
    end
    
    @currentTouch = touches.anyObject.locationInView(self)  
      
  end
  
  def adjust_knob 

    if @deltas.length == 0      
       @adjusting = false
       @deltas = []
       return
    end

    sum = 0
    @deltas.each do |delta| 
      sum += delta
    end
    @angle_adjust += sum / @deltas.length
       
    @angle_adjust = @stop_angle if @angle_adjust < @stop_angle
    @angle_adjust = 2*Math::PI - @stop_angle if @angle_adjust > 2*Math::PI-@stop_angle
    
    @percentage = 100 *  ((@angle_adjust - @stop_angle) / (2*Math::PI - 2*@stop_angle))

    if @deltas.length >= 1
      @deltas.shift
      Dispatch::Queue.main.after 0.01 do
        adjust_knob()
      end        
    end
    if @delegate.respond_to?(:knob_did_change)
      @delegate.knob_did_change(self, @percentage)
    end
    self.setNeedsDisplay()
  end
  
end



