# frozen_string_literal: true

class DiskBasedMemory
  def state
    @state = File.read("lib/test")
  end

  def result
    @result
  end

  def save(state)
    file = File.new('lib/test', 'w')
    file.write([nil, nil, nil, nil, nil, nil, nil, nil, nil])
    file.close
  end

  def save_result(result)
  end
end
