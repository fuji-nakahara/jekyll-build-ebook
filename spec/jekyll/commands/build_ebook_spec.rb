RSpec.describe Jekyll::Commands::BuildEbook do
  describe '.process' do
    subject { described_class.process(options) }

    let(:file_name) { 'example' }
    let(:options) do
      Jekyll::Utils.deep_merge_hashes(
        {
          'source' => source_dir,
          'ebook'  => {
            'destination' => dest_dir,
            'file_name'   => file_name,
          },
        },
        override,
      )
    end
    let(:override) { {} }

    before do
      FileUtils.rm_r(dest_dir) if File.directory?(dest_dir)
    end

    it 'generates the epub file' do
      subject
      expect(File).to exist(dest_dir("#{file_name}.epub"))
    end

    context 'with kindle option' do
      let(:override) do
        {
          'ebook' => {
            'kindle' => true,
          },
        }
      end

      it 'generates the mobi file' do
        subject
        expect(File).to exist(dest_dir("#{file_name}.mobi"))
      end
    end
  end
end
