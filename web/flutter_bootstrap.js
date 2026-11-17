{{flutter_js}}
{{flutter_build_config}}

const status = document.getElementById('status');
const retry = document.getElementById('retry');
const slow = setTimeout(() => {
  status.textContent = 'O carregamento está demorando. Verifique sua conexão.';
  retry.hidden = false;
}, 25000);
_flutter.loader.load({
  onEntrypointLoaded: async (engineInitializer) => {
    try {
      const appRunner = await engineInitializer.initializeEngine();
      await appRunner.runApp();
      clearTimeout(slow);
      document.getElementById('loading')?.remove();
    } catch (_) {
      clearTimeout(slow);
      status.textContent = 'Não foi possível iniciar a calculadora.';
      retry.hidden = false;
    }
  }
});
