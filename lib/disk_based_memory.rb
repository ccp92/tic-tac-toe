# frozen_string_literal: true

class DiskBasedMemory
  def state
    running_dir = File.dirname(__FILE__)
    running_dir = Dir.pwd if (running_dir == '.')

    string = File.read(running_dir + '/memory')
    string.slice!('[')
    string.chomp!(']')
    array = string.split(', ')
    array.map! do |element|
      :O if element == ":O"
      :X if element == ":X"
      nil if element == "nil"
    end

    output = eval(File.read(running_dir + '/memory'))
    pp "file = #{string}" if array != output
    pp "array = #{array}" if array != output
    pp "output = #{output}" if array != output
    @state = output unless File.read(running_dir + "/memory") == ''
  end

  def result
    running_dir = File.dirname(__FILE__)
    running_dir = Dir.pwd if (running_dir == '.')
    output = File.read(running_dir + "/result").to_sym
    @result = output unless File.read(running_dir + "/result") == ''
  end

  def save(state)
    running_dir = File.dirname(__FILE__)
    running_dir = Dir.pwd if (running_dir == '.')
    file = File.new(running_dir + '/memory', 'w')
    file.write(state)
    file.close
  end

  def save_result(result)
    running_dir = File.dirname(__FILE__)
    running_dir = Dir.pwd if (running_dir == '.')
    file = File.new(running_dir + '/result', 'w')
    file.write(result)
    file.close
  end

  def delete_all
    running_dir = File.dirname(__FILE__)
    running_dir = Dir.pwd if (running_dir == '.')
    save([nil, nil, nil, nil, nil, nil, nil, nil, nil])
    File.open(running_dir + '/result', 'w') {|file| file.truncate(0) }
  end
end
