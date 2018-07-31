# frozen_string_literal: true

class DiskBasedMemory
  def state
    output = eval(File.read("memory"))
    @state = output unless File.read("memory") == ''
  end

  def result
    output = File.read("result").to_sym
    @result = output unless File.read("result") == ''
  end

  def save(state)
    file = File.new('memory', 'w')
    file.write(state)
    file.close
  end

  def save_result(result)
    file = File.new('result', 'w')
    file.write(result)
    file.close
  end

  def delete_all
    File.open('memory', 'w') {|file| file.truncate(0) }
    File.open('result', 'w') {|file| file.truncate(0) }
  end
end
