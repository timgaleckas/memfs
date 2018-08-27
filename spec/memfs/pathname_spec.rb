# encoding: UTF-8

require 'spec_helper'
require 'pathname'

module MemFs
  ::RSpec.describe Pathname do
    subject { described_class.new('/test-dir/test-file') }

    let(:random_string) { ('a'..'z').to_a.sample(10).join }

    before do
      _fs.mkdir '/test-dir'
      _fs.touch '/test-dir/test-file', '/test-dir/test-file2', '/test-file2'
    end

    describe '.children' do
      it 'returns children' do
        expect(described_class.new('/test-dir').children.map(&:to_s)).to eq(%w(/test-dir/test-file /test-dir/test-file2))
      end
    end

    describe '.exist?' do
      context 'when the file exists' do
        it 'returns true' do
          expect(subject.exist?).to be true
        end
      end

      context 'when the file does not exist' do
        it 'returns false' do
          expect(described_class.new('/test-dir/blah').exist?).to be false
        end
      end
    end
  end
end

