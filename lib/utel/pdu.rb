module Utel
  class Pdu
    # Encode and decode pdu strings
    def self.encode string
      out = ''
      for i in (0..string.length - 1) do
        t = i%8+1
        next if t == 8
        c = string[i] >> i%8
        b = (string[i+1] || 0) & ((1 << t)-1)
        c = (b << (8-t)) | c
        out << c.to_s(16).rjust(2, '0').upcase
      end
      out
    end

    def self.decode string
      out = ''
      b = 0; d = 0
      string.scan(/.{2}/).each do |part|
        byte = part.to_i(16)
        c = ((byte & ((1 << 7-d)-1)) << d) | b;
        b = byte >> (7-d);
        out << c.chr
        d += 1
        if d == 7
          out << b.chr
          d = 0; b = 0
        end
      end
      out
    end
  end
end
