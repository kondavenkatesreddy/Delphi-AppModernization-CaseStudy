var builder = WebApplication.CreateBuilder(args);

var app = builder.Build();

app.MapGet("/", () => new
{
    application = "Delphi App Modernization Sample API",
    status      = "Running",
    environment = app.Environment.EnvironmentName,
    timestamp   = DateTime.UtcNow
});

// Liveness/readiness endpoint used by both App Service and Kubernetes probes
app.MapGet("/health", () => Results.Ok(new
{
    status    = "Healthy",
    service   = "Delphi.SampleApi",
    timestamp = DateTime.UtcNow
}));

app.MapGet("/config", () => new
{
    keyVaultUri      = Environment.GetEnvironmentVariable("KEY_VAULT_URI") ?? "Not configured",
    appConfigEndpoint = Environment.GetEnvironmentVariable("APP_CONFIG_ENDPOINT") ?? "Not configured"
});

app.Run();
