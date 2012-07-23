class RootViewController < UIViewController
  
  def viewDidLoad
    @knobView1 = KnobView.alloc.initWithFrame([[20,40],[UIScreen.mainScreen.bounds.size.width - 40, UIScreen.mainScreen.bounds.size.width - 40]])
    @knobView1.delegate = self
    @label1 = UILabel.alloc.initWithFrame([[0,310], [320, 20]])
    @label1.textAlignment = UITextAlignmentCenter
    @label1.backgroundColor = UIColor.clearColor
    
    @knobView2 = KnobView.alloc.initWithFrame([[20,330],[UIScreen.mainScreen.bounds.size.width - 200, UIScreen.mainScreen.bounds.size.width - 200]])
    @knobView2.delegate = self
    # @knobView2.innerKnobFillColor = UIColor.blueColor
    @label2 = UILabel.alloc.initWithFrame([[0,450], [160, 20]])
    @label2.textAlignment = UITextAlignmentCenter
    @label2.backgroundColor = UIColor.clearColor

    @knobView3 = KnobView.alloc.initWithFrame([[180,330],[UIScreen.mainScreen.bounds.size.width - 200, UIScreen.mainScreen.bounds.size.width - 200]])
    @knobView3.delegate = self
    @label3 = UILabel.alloc.initWithFrame([[160,450], [160, 20]])
    @label3.textAlignment = UITextAlignmentCenter
    @label3.backgroundColor = UIColor.clearColor
    
    
    self.view.addSubview(@knobView1)
    self.view.addSubview (@label1)
    self.view.addSubview(@knobView2)
    self.view.addSubview (@label2)
    self.view.addSubview(@knobView3)
    self.view.addSubview (@label3)
    self.view.backgroundColor = UIColor.colorWithRed(225.0/255.0, green:225.0/255.0, blue:216.0/255.0, alpha:1.0)
    @reds = []
  end
  
  def knob_did_change(sender, percentage)
    @color1 = UIColor.colorWithRed(241 * (1-percentage/100) / 255.0, green:((91 * (1-percentage/100)) + (177 * percentage/100)) /255.0, blue:((92 * (1-percentage/100)) + (161 * percentage/100)) / 255.0, alpha:1.0)
    
    if sender == @knobView1
      @label1.text = "#{'%.0f' %percentage}"
      @label1.textColor = @color1
    elsif sender == @knobView2
      @label2.text = "#{'%.0f' %percentage}"
      @label2.textColor = @color1
    elsif sender == @knobView3
      @label3.text = "#{'%.0f' %percentage}"
      @label3.textColor = @color1      
    end
  end
    
end