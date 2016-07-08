require_relative "../board"

describe Board do
  describe "#in_play?" do
    context "when board is created" do
      it "returns true" do
        expect(Board.new.in_play?).to eql(true)
      end
    end
  end
  
  describe "#place_token" do
    context "when position is nil" do
      it "places the token" do
        expect(Board.new.place_token("x", 0, 0)).to eq(true)
      end
    end
  end
  
  describe "#place_token" do
    context "when position is occupied" do
      it "does not place the token" do
        board = Board.new
        board.place_token("0", 0, 0)
        expect(board.place_token("x", 0, 0)).to eq(false)
      end
    end
  end
end
