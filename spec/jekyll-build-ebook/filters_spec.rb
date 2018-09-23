RSpec.describe JekyllBuildEbook::Filters do
  describe '::URLFilters' do
    describe '#relative_url' do
      subject { instance.relative_url(input) }

      let(:instance) do
        Class.new do
          include JekyllBuildEbook::Filters::URLFilters
          attr_writer :context
        end.new
      end

      let(:input) { '/assets/ebook.css' }
      let(:page_url) { '/2018-09-19-welcome-to-jekyll.xhtml' }

      let(:page) do
        double('page').tap do |page|
          allow(page).to receive(:url) { page_url }
        end
      end

      before do
        instance.context = double('context').tap do |context|
          allow(context).to receive(:registers) { { page: page } }
        end
      end

      context 'with nil' do
        let(:input) { nil }

        it { is_expected.to be nil }
      end

      context 'with absolute url' do
        let(:input) { 'http://example.com' }

        it { is_expected.to eq input }
      end

      context 'with object which responds to `url`' do
        let(:url) { 'http://example.com' }
        let(:input) do
          double('input').tap do |input|
            allow(input).to receive(:url) { url }
          end
        end

        it { is_expected.to eq url }
      end

      context 'with valid relative path' do
        it { is_expected.to eq 'assets/ebook.css' }
      end
    end
  end
end
