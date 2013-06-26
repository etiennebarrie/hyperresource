module HyperResource::Modules::Changed
  ## Returns +true+ if the given attribute has been changed since creation
  ## time, +false+ otherwise.
  ## If no attribute is given, return whether any attributes have been
  ## changed.
  def changed?(attr=nil)
    @_hr_changed ||= Hash.new(false)
    return @_hr_changed[attr] if attr
    return @_hr_changed.keys.count > 0
  end

  ## Returns a hash containing the names and values of all attributes
  ## which have been changed since creation time.
  def changed_attributes
    return {} unless @_hr_changed
    @_hr_changed.inject({}) do |memo, (attr, value)|
      if value
        memo[attr] = self.attributes[attr]
      end
      memo
    end
  end

  def _hr_mark_changed(attr, is_changed=true) # :nodoc:
    @_hr_changed ||= Hash.new(false)
    @_hr_changed[attr.to_sym] = is_changed
  end

  def _hr_clear_changed # :nodoc:
    @_hr_changed = Hash.new(false)
  end

end
