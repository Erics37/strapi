export default ({ env }) => ({
  host: '0.0.0.0',
  port: 1337,

  app: {
    keys: [
      env('APP_KEY_1', 'dev-key-1-please-change'),
      env('APP_KEY_2', 'dev-key-2-please-change'),
    ],
  },
});

