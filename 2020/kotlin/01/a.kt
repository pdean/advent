fun main() {
    val input = System.`in`.readBytes().toString(Charsets.UTF_8).trim()
    
    val nums = input.split("\n").map(String::toInt)

    for (first in nums) {
        for (second in nums) {
            if (first + second == 2020) {
                println("$first, $second")
                println(first*second)
            }
        }
    }
}
