# frozen_string_literal: true

describe DiskBasedMemory, focus:true do
  let(:memory) { DiskBasedMemory.new }
  it 'has a state of nil' do
    expect(memory.state).to eq('')
  end

  it 'allows a file to exist' do
    memory.save([nil, nil, nil, nil, nil, nil, nil, nil, nil])
    expect(memory.state).to eq('[nil, nil, nil, nil, nil, nil, nil, nil, nil]')
  end
end
