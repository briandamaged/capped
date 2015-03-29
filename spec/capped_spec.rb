

require 'capped'

describe Capped do 

  describe '.while' do

    it 'never invokes the block when the limit is less than or equal to 0' do 
      (0..10).each do |x|

        expect do 
          Capped.while(-x, ->{ true } ) do 
            raise StandardError.new("This should never be invoked")
          end
        end.to raise_exception(Capped::LimitExceededError)

      end
    end


    it 'raises Capped::LimitExceededError if the condition never fails before reaching the iteration limit' do 

      (0..10).each do |limit|
        thing = double('thing')
        expect(thing).to receive(:call).exactly(limit).times

        expect do 
          Capped.while(limit, ->{ true} ) do 
            thing.call
          end
        end.to raise_exception Capped::LimitExceededError
      end

    end


    it 'stops iterating once the condition is reached' do 
      thing = double('thing')
      expect(thing).to receive(:call).exactly(3).times

      x = 0
      Capped.while(10, ->{ x < 3} ) do 
        x += 1
        thing.call
      end
    end


    it 'returns the value passed to the break statement' do 
      expect(
        Capped.while(10, ->{ true} ) do 
          break 5
        end
      ).to eq(5)
    end

  end








  describe '.until' do

    it 'never invokes the block when the limit is less than or equal to 0' do 
      (0..10).each do |x|

        expect do 
          Capped.until(-x, ->{ false } ) do 
            raise StandardError.new("This should never be invoked")
          end
        end.to raise_exception(Capped::LimitExceededError)

      end
    end


    it 'raises Capped::LimitExceededError if the condition is never met before reaching the iteration limit' do 

      (0..10).each do |limit|
        thing = double('thing')
        expect(thing).to receive(:call).exactly(limit).times

        expect do 
          Capped.until(limit, ->{ false } ) do 
            thing.call
          end
        end.to raise_exception Capped::LimitExceededError
      end

    end


    it 'stops iterating once the condition fails' do 
      thing = double('thing')
      expect(thing).to receive(:call).exactly(3).times

      x = 0
      Capped.until(10, ->{ x > 2 } ) do 
        x += 1
        thing.call
      end
    end


    it 'returns the value passed to the break statement' do 
      expect(
        Capped.until(10, ->{ false } ) do 
          break 5
        end
      ).to eq(5)
    end

  end






end
