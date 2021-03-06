# frozen_string_literal: true

require 'json'

class DiskBasedMemory
  def state
    running_dir = __dir__
    board = JSON.parse(File.read(running_dir + '/memory'))
    board.map! { |element| element.to_sym unless element.nil?}
    @state = board unless File.read(running_dir + "/memory") == ''
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
    file.write(state.to_json)
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
