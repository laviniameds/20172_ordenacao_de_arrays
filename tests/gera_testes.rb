tamanhos=[2**8,2**9,2**10,2**11,2**12,2**13,2**14,2**15]
for i in tamanhos do
  # Gera casos aleatórios
  seq=1
  8.times do 
    caso="%02d" % seq
    tamanho="%05d" % i
    nome_arquivo="test_#{tamanho}_#{caso}.txt"
    f=File.new(nome_arquivo,'w')
    f.puts(i)
    r=Random.new(Time.now.to_i)
    i.times do
      f.puts r.rand(1000000)
    end
    f.close
    seq=seq+1
  end
  # Gera ordenado
  tamanho="%05d" % i
  nome_arquivo="test_#{tamanho}_09.txt"
  f=File.new(nome_arquivo,'w')
  f.puts(i)
  i.times do |v|
    f.puts(v)
  end
  f.close
  seq=seq+1
  # Gera ordenado decrescentemente
  tamanho="%05d" % i
  nome_arquivo="test_#{tamanho}_10.txt"
  f=File.new(nome_arquivo,'w')
  f.puts(i)
  i.times do |v|
    f.puts(i-v)
  end
  f.close
  seq=seq+1
end
