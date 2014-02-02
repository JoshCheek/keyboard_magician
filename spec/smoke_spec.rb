require 'open3'

describe 'Hitting the binary just to make sure shit works' do
  Invocation = Struct.new :stdout, :stderr, :status do
    def exitstatus
      status.exitstatus
    end
  end

  it 'works' do
    bin        = File.expand_path '../../bin/tutor', __FILE__
    invocation = Invocation.new *Open3.capture3(bin, stdin_data: 'abc de9')
    expect(invocation.stderr).to eq String.new
    expect(invocation.stdout).to include "num errors:            1"
    expect(invocation.status).to eq 0
  end
end
