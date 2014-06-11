module.exports = {
  sensu: [
    {
      name: 'dc1',
      host: 'localhost',
      ssl: false,
      port: 4567,
      user: 'admin',
      pass: 'secret',
      path: '',
      timeout: 5000
    }
  ],
  uchiwa: {
    user: 'admin',
    pass: 'secret',
    stats: 10,
    refresh: 10000
  }
}
