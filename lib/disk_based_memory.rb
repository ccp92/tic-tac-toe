# frozen_string_literal: true

class DiskBasedMemory
  def state
    output = eval(File.read("lib/memory"))
    @state = output unless File.read("lib/memory") == ''
  end

  def result
    output = File.read("lib/result").to_sym
    @result = output unless File.read("lib/result") == ''
  end

  def save(state)
    file = File.new('lib/memory', 'w')
    file.write(state)
    file.close
  end

  def save_result(result)
    file = File.new('lib/result', 'w')
    file.write(result)
    file.close
  end

  def delete_all
    File.open('lib/memory', 'w') {|file| file.truncate(0) }
    File.open('lib/result', 'w') {|file| file.truncate(0) }
  end
end
