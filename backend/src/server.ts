import app from './app';
import { env } from './config/env';

app.listen(env.port, () => {
  console.log(`Fellow4U backend listening on port ${env.port}`);
});
