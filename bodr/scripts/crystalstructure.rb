#!/usr/bin/env ruby
# (c) 2006 Carsten Niehaus <cniehaus@kde.org>
# License: MIT

#Example-syntax of a CML 2.3-crystal
#<molecule id="crystal1">
#  <crystal z="4">
#    <scalar id="sc1" title="a" units="units:angstrom">4.500</scalar>
#    <scalar id="sc2" title="b" units="units:angstrom">4.500</scalar>
#    <scalar id="sc3" title="c" units="units:angstrom">4.500</scalar>
#    <scalar id="sc4" title="alpha" units="units:degrees">90</scalar>
#    <scalar id="sc5" title="beta" units="units:degrees">90</scalar>
#    <scalar id="sc6" title="gamma" units="units:degrees">90</scalar>
#    <symmetry id="s1" spaceGroup="Fm3m"/>
#  </crystal>
#  <atomArray>
#    <atom id="a1" elementType="Na" formalCharge="1" xFract="0.0" yFract="0.0" zFract="0.0"/>
#    <atom id="a2" elementType="Cl" formalCharge="-1" xFract="0.5" yFract="0.0" zFract="0.0"/>
#  </atomArray>
#</molecule>

class Crystal
  #Check if the crystal is valid or not
  def valid?
    # 1-2   Triclinic
    # 3-15  Monoclinic
    # 16-74 Orthorhombic
    # 75-142  Tetragonal
    # 143-167 Rhombohedral (Trigonal)
    # 168-194 Hexagonal
    # 195-230 Cubic

    if not @spacegroup <= 230
      puts "Spacegroup to high: "+@spacegroup.to_s
      return false
    elsif @spacegroup < 1
      puts "Spacegroup to small: "+@spacegroup.to_s
      return false
    end

    case @spacegroup
    when 1..2
      if @system != "tri"
        puts "Triclinic (1-2): #{@system}, #{@spacegroup.to_s}"
      end
      if @a == @b or @a == c or @b == @c
        puts "Same length! #{@a}, #{@b}, #{@c}"
      end
      if @alpha == @beta or @alpha == @gamma or @beta == @gamma
        puts "Same angle! #{@alpha}, #{@beta}, #{@gamma}"
      end
    when 3..15
      if @system != "mono"
        puts "#{@id}: Monoclinic (3-15): #{@system}, #{@spacegroup.to_s}"
      end
      if @a == @b or @a == c or @b == @c
        puts "Same length! #{@a}, #{@b}, #{@c}"
      end
    when 16..74
      if @system != "or"
        puts "#{@id}: Orthorhombic (16-74): #{@system}, #{@spacegroup.to_s}"
      end
      if @a == @b or @a == c or @b == @c
        puts "Same length! #{@a}, #{@b}, #{@c}"
      end
    when 75..142
      if @system != "tet"
        puts "#{@id}: Tetragonal (75-142): #{@system}, #{@spacegroup.to_s}"
      end
      if @a != @b 
        puts "#{@a} != #{@b}"
      end
    when 143..167
      if @system != "rh"
        puts "#{@id}: Rhombohedral (143-167): #{@system}, #{@spacegroup.to_s}"
      end
    when 168..194
      if @system != "hcp"
        puts "#{@id}: Hexagonal (168-194): #{@system}, #{@spacegroup.to_s}"
      end
    when 195..130
      if @system != "ccp" and @system != "bcc" and @system != "sc"
        puts "#{@id}: Cubic (195-230): #{@system}, #{@spacegroup.to_s}"
      end
    end

    return true
  end

  attr_accessor :a, :b, :c, :alpha, :beta, :gamma, :spacegroup, :id, :system
end

$xmlfile = <<EOS
<?xml version="1.0" encoding="utf-8"?>
<list xmlns="http://www.xml-cml.org/schema"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xmlns:bo="http://www.blueobelisk.org/dict/terminology"
      xmlns:boUnits="http://www.blueobelisk.org/dict/units"
      xmlns:units="http://www.xml-cml.org/units/units"
      xmlns:siUnits="http://www.xml-cml.org/units/siUnits"
      xmlns:bibx="http://bibtexml.sf.net/"
      xsi:schemaLocation=\"http://www.xml-cml.org/schema ../schemas/cml23.xsd
                         http://bibtexml.sf.net/        ../schemas/bibtexml.xsd"
      id="crystalStructure"
      title="properties of the crystals">

  <metadataList>
    <metadata name="dc:title" content="Blue Obelisk Element Repository" />
    <metadata name="dc:creator" content="The Blue Obelisk Movement" />
    <metadata name="dc:license" content="The MIT License" />
    <metadata name="dc:contributor" content=\"Carsten Niehaus" />
  </metadataList>
EOS

# return the chemical symbol of the element with the given number
def get_symbol(number)
  elementsymbols = ["dummy","H", "He", "Li", "Be", "B", "C", "N", "O", "F", "Ne", "Na", "Mg", "Al", "Si", "P", "S", "Cl", "Ar", "K", "Ca", "Sc", "Ti", "V", "Cr", "Mn", "Fe", "Co", "Ni", "Cu", "Zn", "Ga", "Ge", "As", "Se", "Br", "Kr", "Rb", "Sr", "Y", "Zr", "Nb", "Mo", "Tc", "Ru", "Rh", "Pd", "Ag", "Cd", "In", "Sn", "Sb", "Te", "I", "Xe", "Cs", "Ba", "La", "Ce", "Pr", "Nd", "Pm", "Sm", "Eu", "Gd", "Tb", "Dy", "Ho", "Er", "Tm", "Yb", "Lu", "Hf", "Ta", "W", "Re", "Os", "Ir", "Pt", "Au", "Hg", "Tl", "Pb", "Bi", "Po", "At", "Rn", "Fr", "Ra", "Ac", "Th", "Pa", "U", "Np", "Pu", "Am", "Cm", "Bk", "Cf", "Es", "Fm", "Md", "No", "Lr", "Rf", "Db", "Sg", "Bh", "Hs", "Mt", "Ds", "Rg", "Uub", "Uut", "Uuq", "Uup", "Uuh"]

  return elementsymbols[number]
end

def process_element(content)
  stuff = content.split(' ')

  crystal = Crystal.new

  crystal.id = stuff[0]
  crystal.a = stuff[3].to_f
  crystal.b = stuff[4].to_f
  crystal.c = stuff[5].to_f
  crystal.alpha = stuff[6].to_f
  crystal.beta = stuff[7].to_f
  crystal.gamma = stuff[8].to_f
  crystal.spacegroup = stuff[2].to_i
  crystal.system = stuff[1]

  symbol = get_symbol(stuff[0].to_i)

  return unless crystal.valid?

xml = <<ELEMENTXML
  <molecule id="#{symbol}#{crystal.id}">
    <crystal>
      <scalar id="sc1" title="a" units="units:pm">#{crystal.a}</scalar>
      <scalar id="sc2" title="b" units="units:pm">#{crystal.b}</scalar>
      <scalar id="sc3" title="c" units="units:pm">#{crystal.c}</scalar>
      <scalar id="sc4" title="alpha" units="units:degrees">#{crystal.alpha}</scalar>
      <scalar id="sc5" title="beta" units="units:degrees">#{crystal.beta}</scalar>
      <scalar id="sc6" title="gamma" units="units:degrees">#{crystal.gamma}</scalar>
      <symmetry id="s1" spaceGroup="#{crystal.spacegroup}" />
    </crystal>
    <atomArray>
      <atom id="a1" elementType="#{symbol}" xFract="0.0" yFract="0.0" zFract="0.0" />
    </atomArray>
  </molecule>
ELEMENTXML

  $xmlfile << xml
end

File.open("crystalstructures.txt") do |file|
  file.each {|line| 
    process_element(line) unless line =~ /^#/
  }
end

$xmlfile << "</list>\n";

File.open("crystalstructures.xml", "w+") { |f| 
  f << $xmlfile 
}
