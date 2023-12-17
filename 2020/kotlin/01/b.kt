fun main() {
    val input = System.`in`.readBytes().toString(Charsets.UTF_8).trim()
    val nums = input.split("\n").map(String::toInt)

    for (first in nums) {
        for (second in nums) {
            for (third in nums) {
                if (first + second + third == 2020) {
                    println("$first, $second, $third")
                    println(first*second*third)
                }
            }
        }
    }
}
