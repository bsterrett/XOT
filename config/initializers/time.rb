class Time
  def past?
    return ( Time.now <=> self ) == 1 ? true : false
  end

  def in_next_hour?
    if (Time.now <=> self) == -1  and  (Time.now+3600 <=> self ) == 1
      return true
    else
      return false
    end
  end
end