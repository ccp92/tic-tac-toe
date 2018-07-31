# frozen_string_literal: true

describe DiskBasedMemory do
  let(:memory) { DiskBasedMemory.new }
  before { memory.delete_all }

  it 'has a state of nil' do
    expect(memory.state).to eq(nil)
  end

  it 'has a result of nil' do
    expect(memory.result).to eq(nil)
  end

  it 'allows a file to exist' do
    memory.save([nil, nil, nil, nil, nil, nil, nil, nil, nil])
    expect(memory.state).to eq([nil, nil, nil, nil, nil, nil, nil, nil, nil])
  end

  it 'allows for a mark to be placed on the board' do
    memory.save([:O, nil, nil, nil, nil, nil, nil, nil, nil])
    expect(memory.state).to eq([:O, nil, nil, nil, nil, nil, nil, nil, nil])
  end

  it 'allows a winner to be saved' do
    memory.save_result(:winner)
    expect(memory.result).to eq(:winner)
  end

  it 'allows a draw to be saved' do
    memory.save_result(:draw)
    expect(memory.result).to eq(:draw)
  end
end
