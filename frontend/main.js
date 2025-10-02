// main.js - Official Reown AppKit Initialization (verified from docs.reown.com/appkit/javascript/core/installation, Oct 2025)
const { createAppKit } = await import('https://unpkg.com/@reown/appkit@1.7.7');
const { base } = await import('https://unpkg.com/@reown/appkit/networks');
const { ethers } = await import('https://cdn.jsdelivr.net/npm/ethers@5.7.2/dist/ethers.umd.min.js');

// Expose globals
window.ethers = ethers;

// Project ID from Reown Dashboard
const projectId = '0808ceb934963ee4f7d69774d29cb28a';

// Contract configs (your 16 Base addresses/ABIs)
const contracts = {
  TipJar: { address: '0xc1EFbf01F45E2291930ca1b4cFEE7ba7cA2a0389', abi: ['function tip() public payable'] },
  VotePoll: { address: '0xE92Af969Eda2739d3892bD331912924203914649', abi: ['function vote(uint256 option) public'] },
  SimpleTimer: { address: '0xC17803c254831208B8a9c352a1B9e1b0c5d8e0e3', abi: ['function startTimer() public'] },
  GiveawayBox: { address: '0x4Ed8afadBFb646be20B250574c5b088Aeed70E1c', abi: ['function enter() public'] },
  StorageUnit: { address: '0xbB5f6aB56147c3644A481FDC21196ca4A2EEe60D', abi: ['function store(uint256 value) public'] },
  RandomPicker: { address: '0x9aDF3D4233A75cc330909aDC9b1A60bFC1567567', abi: ['function enter() public'] },
  GreetingCard: { address: '0xa27C3d38BCd9738eecA4f44E7259f1Ad9E605387', abi: ['function setGreeting(string memory message) public'] },
  TokenTracker: { address: '0xF717E1c9fca1d3BD1823907eF120dc7a619445a1', abi: ['function updateBalance(address user, uint256 amount) public'] },
  EventTracker: { address: '0x70205809e4a0153A1a7fE165F24f83d32bd5DB3b', abi: ['function logEvent(string memory name) public'] },
  PriceChecker: { address: '0x27c8D16d8Eba789eDB777A983e307D726bEC56fA', abi: ['function updatePrice(uint256 newPrice) public'] },
  TodoList: { address: '0xD080Ebc9b6207A5B6607690E5A98aA81A0F7774a', abi: ['function addTask(string memory description) public'] },
  Scoreboard: { address: '0x3749c8E42c7D7A2E856Ab2272bd5DD0dCD530036', abi: ['function updateScore(uint256 score) public'] },
  ProfileBadge: { address: '0xE22fAEdE533f9b2d321B36f9a6CaAe91404A83ff', abi: ['function assignBadge(string memory badge) public'] },
  PollResultsViewer: { address: '0x5C0774903cD49e8a145E2A3900965cb4684C1C7C', abi: ['function updateResult(uint256 option, uint256 count) public'] },
  EventReminder: { address: '0x707d306210a414cFD63EdcFe0fA11f2b37823b3e', abi: ['function setReminder(string memory eventName, uint256 timestamp) public'] },
  FeedbackCollector: { address: '0x57541598FD78DC06B9aDF135467fCDD103643262', abi: ['function submitFeedback(string memory message) public'] }
};

// Initialize AppKit (official pattern)
await createAppKit({
  projectId,
  networks: [base],
  metadata: {
    name: 'BaseTools',
    description: 'Utility contracts on Base with WalletConnect',
    url: window.location.href,
    icons: ['https://reown.com/favicon.ico']
  },
  features: {
    socials: ['google', 'twitter'],
    email: true,
    swap: true,
    onramp: true,
    analytics: true,
    paymaster: true
  }
});

// Event Listeners (for connect/disconnect)
window.addEventListener('appkit-ready', () => {
  console.log('AppKit ready');
});

const { getProvider, on } = window.appKit; // Global from AppKit

on('connect', async ({ address }) => {
  document.getElementById('address').textContent = address;
  document.getElementById('connected').classList.add('active');
  Object.keys(contracts).forEach(key => {
    const elem = document.getElementById(key.toLowerCase());
    if (elem) elem.classList.add('active');
  });
});

on('disconnect', () => {
  document.getElementById('connected').classList.remove('active');
  Object.keys(contracts).forEach(key => {
    const elem = document.getElementById(key.toLowerCase());
    if (elem) elem.classList.remove('active');
  });
});

// Contract Interaction Actions (ethers.js)
const actions = [
  { id: 'sendTipBtn', contract: 'TipJar', fn: 'tip', input: 'tipAmount', process: (input) => ({ value: ethers.utils.parseEther(input) }) },
  { id: 'voteBtn', contract: 'VotePoll', fn: 'vote', input: 'voteOption', process: (input) => [Number(input)] },
  { id: 'startTimerBtn', contract: 'SimpleTimer', fn: 'startTimer', input: null },
  { id: 'enterGiveawayBtn', contract: 'GiveawayBox', fn: 'enter', input: null },
  { id: 'storeBtn', contract: 'StorageUnit', fn: 'store', input: 'storeValue', process: (input) => [Number(input)] },
  { id: 'enterRandomBtn', contract: 'RandomPicker', fn: 'enter', input: null },
  { id: 'setGreetingBtn', contract: 'GreetingCard', fn: 'setGreeting', input: 'greetingMessage', process: (input) => [input] },
  { id: 'updateTokenBtn', contract: 'TokenTracker', fn: 'updateBalance', input: 'tokenAmount', process: (input, addr) => [addr, Number(input)] },
  { id: 'logEventBtn', contract: 'EventTracker', fn: 'logEvent', input: 'eventName', process: (input) => [input] },
  { id: 'updatePriceBtn', contract: 'PriceChecker', fn: 'updatePrice', input: 'priceValue', process: (input) => [Number(input)] },
  { id: 'addTaskBtn', contract: 'TodoList', fn: 'addTask', input: 'taskDescription', process: (input) => [input] },
  { id: 'updateScoreBtn', contract: 'Scoreboard', fn: 'updateScore', input: 'scoreValue', process: (input) => [Number(input)] },
  { id: 'assignBadgeBtn', contract: 'ProfileBadge', fn: 'assignBadge', input: 'badgeName', process: (input) => [input] },
  { id: 'updatePollResultBtn', contract: 'PollResultsViewer', fn: 'updateResult', input: ['pollOption', 'pollCount'], process: (inputs) => [Number(inputs[0]), Number(inputs[1])] },
  { id: 'setReminderBtn', contract: 'EventReminder', fn: 'setReminder', input: ['reminderName', 'reminderTimestamp'], process: (inputs) => [inputs[0], Number(inputs[1])] },
  { id: 'submitFeedbackBtn', contract: 'FeedbackCollector', fn: 'submitFeedback', input: 'feedbackMessage', process: (input) => [input] }
];

actions.forEach(({ id, contract, fn, input, process }) => {
  const btn = document.getElementById(id);
  if (btn) {
    btn.addEventListener('click', async () => {
      try {
        const provider = new ethers.providers.Web3Provider(await getProvider());
        const signer = provider.getSigner();
        const addr = await signer.getAddress();
        const contractObj = new ethers.Contract(contracts[contract].address, contracts[contract].abi, signer);
        let params = [];
        if (input) {
          const inputValue = Array.isArray(input) ? input.map(i => document.getElementById(i).value) : document.getElementById(input).value;
          params = process ? process(inputValue, addr) : inputValue;
        }
        const tx = await contractObj[fn](...params);
        document.getElementById('status').textContent = `Tx sent: ${tx.hash}`;
        // Track for Analytics (Builder Rewards boost)
        window.appKit?.trackEvent?.({ name: `${contract}_${fn}` });
        await tx.wait();
        document.getElementById('status').textContent = `Tx confirmed: ${tx.hash}`;
      } catch (err) {
        document.getElementById('status').textContent = `Error: ${err.message}`;
        console.error(err);
      }
    });
  }
});
