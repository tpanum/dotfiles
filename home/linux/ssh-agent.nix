{ ... }:
{
  # macOS has its own agent; Linux needs one started per user session.
  services.ssh-agent.enable = true;
}
