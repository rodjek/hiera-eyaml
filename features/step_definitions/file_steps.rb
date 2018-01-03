Then(/the file "(.*?)" should contain a PNG image/) do |file|
  data = nil
  File.open(expand_path(file), 'rb') do |f|
    data = f.read
  end

  header = data[0..7].unpack('C*')

  # http://www.libpng.org/pub/png/spec/1.2/PNG-Structure.html
  expect(header).to eq([137, 80, 78, 71, 13, 10, 26, 10])
end
