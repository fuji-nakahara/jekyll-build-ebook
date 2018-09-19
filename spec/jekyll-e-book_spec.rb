RSpec.describe JekyllEBook do
  subject(:ebook) { Pathname.new(ebook_dir("#{file_name}.epub")) }

  let(:file_name) { 'example' }
  let(:override) do
    {
      'source'      => source_dir,
      'destination' => dest_dir,
      'ebook'       => {
        'destination' => ebook_dir,
        'file_name'   => file_name,
      },
    }
  end

  before do
    FileUtils.rm_rf(ebook_dir)
    Jekyll::Site.new(Jekyll.configuration(override)).process
  end

  it 'generates an epub file' do
    expect(ebook).to exist
  end
end
