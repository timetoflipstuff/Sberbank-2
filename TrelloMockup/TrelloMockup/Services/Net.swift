
protocol Net {
    func getNotes(block: @escaping ([Note]) -> Void )
}
