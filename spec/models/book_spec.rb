require 'rails_helper'

RSpec.describe Book, type: :model do
  describe '適切な条件であるため有効' do
    it '10桁のisbn・nil無し・適切なrelease_date' do
      @book = FactoryBot.create(:free)
      expect(@book).to be_valid
    end
    it '13桁のisbn・nil無し・適切なrelease_date' do
      @book = FactoryBot.create(:infection)
      expect(@book).to be_valid
    end
  end
  
  describe 'ISBN関連の異常' do
    before do
      @book = Book.new(
        title: 'sample_book_title',
        author: 'sample_author',
        publisher: 'sample_publisher',
        release_date: Date.today
        )
    end
    context '桁数' do
      it '桁数が少ないため無効。' do
        @book.isbn = 123456789
        expect(@book).to be_invalid
      end
      it '10~13桁の間であるため無効。' do
        @book.isbn = 1234567890123456
        expect(@book).to be_invalid
      end
      it '桁数が多いため無効。' do
        @book.isbn = 1234567890123456
        expect(@book).to be_invalid
      end
    end
    context '数値以外の不正'
      it '数値以外が使われているため無効' do
        @book.isbn = '123456789a'
        expect(@book).to be_invalid
      end
      it 'nilであるため無効' do
        @book.isbn = ''
        expect(@book).to be_invalid
      end
  end
  describe '要素のnilによる異常' do
    before do
      @book = Book.new(
        isbn: 1234567890,
        title: 'sample_book_title',
        author: 'sample_author',
        publisher: 'sample_publisher',
        release_date: Date.today
        )
    end
    it 'titleがnilであるため登録できない' do
      @book.title = ''
      expect(@book).to be_invalid
    end
    it 'authorがnilであるため登録できない' do
      @book.author = ''
      expect(@book).to be_invalid
    end
    it 'publisherがnilであるため登録できない' do
      @book.publisher = ''
      expect(@book).to be_invalid
    end
  end
  describe 'release_date関連の異常' do
    before do
      @book = Book.new(
        isbn: 1234567890123,
        title: 'sample_book_title3',
        author: 'sample_author3',
        publisher: 'sample_publisher3'
        )
    end
    it 'release_dateがnilであるため登録できない' do
      @book.release_date = ""
      expect(@book).to be_invalid
    end
    it 'release_dateがdate形式でないため登録できない' do
      @book.release_date = '2020年1月1日'
      expect(@book).to be_invalid
    end
    it 'release_dateが未来であるため登録できない' do
      @book.release_date = (Date.today + 1)
      expect(@book).to be_invalid
    end
  end
end