import io/FileReader
import text/StringTokenizer

main: func {

    totalBaseCount := 0
    GCCount        := 0
    GCFraction     : Float
    file           := FileReader new ("Homo_sapiens.GRCh37.67.dna_rm.chromosome.Y.fa", "r")
    buffer         := Buffer new (1024)
    firstLine      := true

    while( file hasNext?() ){
        file read(buffer)
        lines := buffer split('\n')
        lines each (|line| 
            if ( !firstLine ){
                for ( i in 0..line size ) {
                    match (line[i]){
                        case 'A' => totalBaseCount+=1
                        case 'C' => 
                            totalBaseCount+=1
                            GCCount+=1
                        case 'G' => 
                            totalBaseCount+=1
                            GCCount+=1
                        case 'T' => totalBaseCount+=1
                    }
                }
            } else {
                firstLine = false
            }
        )
    }
    file close()

    GCFraction = (GCCount as Float) / (totalBaseCount as Float) * 100.0
    GCFraction toString() println()
}
