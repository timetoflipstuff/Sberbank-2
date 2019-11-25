protocol NetFetcher {
    func getNotes(block: @escaping ([Note]) -> Void )
}
