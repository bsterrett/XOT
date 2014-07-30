class Time
  def past?
    # the constant approximates the time for arithemtic
    return ( self.utc - Time.now.utc + 0.0002 < 0 )
  end

  def in_next_hour?
    return ( self.utc - Time.now.utc > 0 && self.utc - Time.now.utc < 3600 )
  end
end