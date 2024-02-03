let audioPlayer = null;
let audioPlayer2 = null;
let banTimesValue = 0;
let banTimesType = '';
let banTimesMessage = '';
const store = Vuex.createStore({
    state: {},
    mutations: {},
    actions: {}
});

const app = Vue.createApp({
    data: () => ({
        show: false,
        locale: '',
        playerStateAttribute: [],
        adminPermissions: [],
        permissionSystem : {
            ['warnAction'] : [
                {name : 'warnPlayer', label : 'Warn Players'},
                {name : 'kickPlayer', label : 'Kick Players'},
                {name : 'jailPlayer', label : 'A.Jail Players'},
                {name : 'banPlayer', label : 'Ban Players'},
                {name : 'permaBanPlayer', label : 'P.Ban Players'},
            ],
            ['ingameAction'] : [
                {name : 'spectatePlayer', label : 'Spectate'},
                {name : 'revivePlayer', label : 'Revive'},
                {name : 'killPlayer', label : 'Kill'},
                {name : 'freezePlayer', label : 'Freeze'},
                {name : 'gotoPlayer', label : 'Goto'},
                {name : 'bringPlayer', label : 'Bring'},
                {name : 'markGps', label : 'Mark GPS'},
                {name : 'giveItem', label : 'Give Item'},
                {name : 'giveCash', label : 'Give Cash'},
                {name : 'giveBank', label : 'Give Bank'},
                {name : 'devtools', label : 'Dev Tools'},
                {name : 'noclip', label : 'Noclip'},
                {name : 'godmode', label : 'God Mode'},
                {name : 'healPlayer', label : 'Heal'},
                {name : 'invisible', label : 'Invisible'},
                {name : 'showPlayerName', label : 'Show Name'},
                {name : 'sendPM', label : 'Send PM'},
                {name : 'giveVehicle', label : 'Give Vehicle'},
                {name : 'giveVehicleDatabase', label : 'Give Veh DB'},
                {name : 'showcoords', label : 'Show Coords'},
                {name : 'giveClothingMenu', label : 'Clothing Menu'},
                {name : 'takePicture', label : 'Take Picture'},
                {name : 'clearInventory', label : 'Clear Inventory'},
                {name : 'setJob', label : 'Set Job'},
                {name : 'repairVehicle', label : 'Repair Vehicle'},
                {name : 'tpmarker', label : 'TP Marker'},
                {name : 'givePerm', label : 'Give Perm'},
                {name : 'staffChat', label : 'Staff Chat'},
             
            ],
            ['serverAction'] : [
                {name : 'clearVehicle', label : 'Clear Vehicle'},
                {name : 'allRevive', label : 'All Revive'},
                {name : 'clearArea', label : 'Clear Area'},
                {name : 'changeWeather', label : 'Change Weather'},
                {name : 'changeTime', label : 'Change Time'},
                {name : 'unbanPlayer', label : 'Unban Player'},
                {name : 'announce', label : 'Announce'},
                {name : 'freezeTime', label : 'Freeze Time'},
                {name : 'runCommand', label : 'Run Command'},
                {name : 'unjailPlayer', label : 'Unjail Player'},
            ]
        },
           
               
            
    
        fastPanelAdminPermissions: {
            giveitempanel: {
                placeholder: "",
                placeholder2: '',
                label: "",
                background: "giveitemfastpanel",
                input: true,
                name: "giveitem",
                text1: "",
                text2: ""
            },
            givevehiclepanel: {
                placeholder: "",
                label: "",
                input: true,
                background: "givevehiclefastpanel",
                text1: "",
                text2: "",
                name: "givevehicle",
                text3: ""
            },
        },

        interactionAdminPermissions: {
            giveitem: {
                placeholder: "",
                placeholder2: '',
                label: "",
                background: "giveitembackground",
                input: true,
                name: "giveitem",
                text1: "",
                text2: ""
            },
            giveitempanel: {
                placeholder: "",
                placeholder2: '',
                label: "",
                background: "giveitembackground",
                input: true,
                name: "giveitem",
                text1: "",
                text2: ""
            },
            givemoney: {
                placeholder: "",
                label: "",
                input: true,
                background: "givemoneybackground",
                text1: "",
                text2: "",
                name: "givemoney",
                text3: ""
            },
            setjob: {
                placeholder: "",
                placeholder2: '',
                label: "",
                background: "setjobbackground",
                input: true,
                name: "setjob",
                text1: "",
                text2: ""
            },
            givevip: {
                placeholder: " ",
                label: "",
                background: "givevipbackground",
                input: false,
                name: "givevip",
                text1: "",
                text2: ""
            },
            giveperm: {
                placeholder: "",
                label: "",
                background: "givestaffbackground",
                input: false,
                name: "giveperm",
                text1: "",
                text2: ""
            },
            // giveadmin: {
            //     placeholder: "",
            //     label: "",
            //     background: "giveadminbackground",
            //     input: false,
            //     name: "giveadmin",
            //     text1: "",
            //     text2: ""
            // },
            // givesuperadmin: {
            //     placeholder: "",
            //     label: "",
            //     background: "givesuperadminbackground",
            //     input: false,
            //     name: "givesuperadmin",
            //     text1: "",
            //     text2: ""
            // },
            pm: {
                placeholder: "",
                label: "",
                background: "pmbackground",
                input: true,
                name: "pm",
                text1: "",
                text2: ""
            },
            givevehicle: {
                placeholder: "",
                label: "",
                input: true,
                background: "givevehiclebackground",
                text1: "",
                text2: "",
                name: "givevehicle",
                text3: ""
            },
            givevehiclepanel: {
                placeholder: "",
                label: "",
                input: true,
                background: "givevehiclebackground",
                text1: "",
                text2: "",
                name: "givevehicle",
                text3: ""
            },
            announce: {
                placeholder: "",
                label: "",
                background: "announcebackground",
                input: true,
                name: "announce",
                text1: "",
                text2: ""
            },

            weather: {
                background: "weatherbackground",
                weather: [{
                    name: "EXTRASUNNY",
                    label: "Extra Sunny",
                    image: "extrasunny"
                },
                {
                    name: "CLEAR",
                    label: "Clear",
                    image: "weatherclear"
                },
                {
                    name: "CLEARING",
                    label: "Clearing",
                    image: "weatherclearing"
                },
                {
                    name: "BLIZZARD",
                    label: "Blizzard",
                    image: "weatherblizzard"
                },
                {
                    name: "OVERCAST",
                    label: "Overcast",
                    image: "weatherovercast"
                },
                {
                    name: "THUNDER",
                    label: "Thunder",
                    image: "weatherhunder"
                },
                {
                    name: "CLOUDS",
                    label: "Cloudy",
                    image: "weathercloudy"
                },
                {
                    name: "FOGGY",
                    label: "Foggy",
                    image: "weatherfoggy"
                },
                {
                    name: "SMOG",
                    label: "Smog",
                    image: "weathersmog"
                },
                {
                    name: "hallowen",
                    label: "Hallowen",
                    image: "weatherhallowen"
                },
                {
                    name: "NEUTRAL",
                    label: "Neutral",
                    image: "weatherneutral"
                },

                {
                    name: "RAIN",
                    label: "Rain",
                    image: "weatherrain"
                },
                {
                    name: "SNOW",
                    label: "Snow",
                    image: "weathersnow"
                },
                {
                    name: "XMAS",
                    label: "XMas",
                    image: "weatherxmas"
                }
                ]
            },
            time: {
                background: "timebackground",
                weather: [{
                    name: "06",
                    label: "06:00",
                    image: "time06"
                },
                {
                    name: "08",
                    label: "08:00",
                    image: "time08"
                },
                {
                    name: "10",
                    label: "10:00",
                    image: "time10"
                },
                {
                    name: "12",
                    label: "12:00",
                    image: "time12"
                },
                {
                    name: "16",
                    label: "16:00",
                    image: "time16"
                },
                {
                    name: "20",
                    label: "20:00",
                    image: "time20"
                },
                {
                    name: "00",
                    label: "00:00",
                    image: "time00"
                }
                ]
            }
        },
        forPlayerAdminPermissions: [],

        serverAdminSettings: [],

        scoreBoardData: [],
        filterScoreBoardData: [],
        scoreBoardSearchIcon: [],

        devtoolsMenu: [],

        spectateButtons: [],


        banTimes: [{
            name: "1",
            type: "hour",
            label: "1 Hour"
        },
        {
            name: "2",
            type: "hour",
            label: "2 Hour"
        },
        {
            name: "4",
            type: "hour",
            label: "4 Hour"
        },
        {
            name: "6",
            type: "hour",
            label: "6 Hour"
        },
        {
            name: "12",
            type: "hour",
            label: "12 Hour"
        },
        {
            name: "18",
            type: "hour",
            label: "18 Hour"
        },
        {
            name: "1",
            type: "day",
            label: "1 day"
        },
        {
            name: "2",
            type: "day",
            label: "2 day"
        },
        {
            name: "4",
            type: "day",
            label: "4 day"
        },
        {
            name: "7",
            type: "day",
            label: "7 day"
        }
        ],
        timeJail: [{
            name: "1",
            type: "min",
            label: "1 Min"
        },
        {
            name: "5",
            type: "min",
            label: "5 Min"
        },
        {
            name: "10",
            type: "min",
            label: "10 Min"
        },
        {
            name: "20",
            type: "min",
            label: "20 Min"
        },
        {
            name: "30",
            type: "min",
            label: "30 Min"
        },
        {
            name: "40",
            type: "min",
            label: "40 Min"
        },
        {
            name: "1",
            type: "hour",
            label: "1 Hour"
        },
        {
            name: "2",
            type: "hour",
            label: "2 Hour"
        },
        {
            name: "4",
            type: "hour",
            label: "4 Hour"
        },
        {
            name: "7",
            type: "hour",
            label: "7 Hour"
        }
        ],


        stafMenuPage: "",
        command: "",
        output: [],
        devtoolsMenuValue: false,
        runcmd: false,
        checkedStatus: [],

        playerStateAttributeValue: false,
        playerStatePageHeader: "",
        setPlayerStateAttributeValue: false,
        setPlayerStatePageBackground: false,
        setPlayerStatePageHeader: "",
        playerAttrModel: "",
        setPlayerStateInput: "",
        setPlayerStateInput2: "",
        vForValue: false,

        scoreBoardAnimButton: [],
        scoreBoardAnimActiveButton: null,
        scoreBoardAnimActiveButtonSearchBar: false,
        scoreBoardSearchBarInputValue: "",

        forPlayerInteraction: false,

        playerSelect: false,
        playerSelectButton: [],


        forCopiedDiscordEtc: false,

        selfStaffData: false,

        adminChatModel: "",
        adminChatData: [],

        onlineStaff: 0,

        spectateMenu: true,
        spectateModel: "",
        spectateModelLet: false,
        banPanel: false,

        isDragInitialized: false,
        positionsData: {},

        notifications: [],

        showName: false,
        showBlip: false,

        allDataBaseData: [],


        bannedButton: false,
        banPlayerValue: false,
        banPlayerValueCache: [],
        playerSelectInputDayModel: '',
        playerSelectInputHoursModel: '',

        jailPlayerValue: false,

        forCopiedDiscordEtcAlt: false,

        showCoords: false,

        timeValueInput: "",



        serverlogo: '',


        // version 1.5.0

        mainSettings : [
            {
                image : 'totalshowplayers',
                label : 'Total Players',
                value : 0,
            },
            {
                image : 'totalshowmoney',
                label : 'Total Cash',
                value : 0,
            },
            {
                image : 'totalshowbank',
                label : 'Total Bank',
                value : 0,
            }
        ],
        moneyData : '',
        totalMoney : 0,
        totalBank : 0,
    }),

    methods: {
        givePermPlayer(name,val){
            clicksound("click");
            postNUI("givepermPlayer", {
                name : name,
                val : val,
                plyid: this.playerSelect.id,
               
            });
        },
        closeFastPanel() {
            this.stafMenuPage = "";
            postNUI("closeAdminMenu");
        },
        openAdminDevtoolsMenuValue(val) {
            if (val) {

                if (this.checkedStatus[val]) {
                    if (val == 'showcoords') {
                        postNUI("selectPlayerValue", {
                            name: 'showCoords',
                            plyid: this.selfStaffData.id,
                        });
                    } else if (val == 'showmouse') {
                        postNUI("selectPlayerValue", {
                            name: 'showMouse',
                            plyid: this.selfStaffData.id,
                        });
                    } else if (val == 'noclip') {
                        postNUI("selectPlayerValue", {
                            name: 'noclip',
                            plyid: this.selfStaffData.id,
                        });
                    }
                } else {
                    if (val == 'showcoords') {
                        postNUI("selectPlayerValue", {
                            name: 'showCoords',
                            plyid: this.selfStaffData.id,
                        });
                    }
                    if (val == 'noclip') {
                        postNUI("selectPlayerValue", {
                            name: 'noclip',
                            plyid: this.selfStaffData.id,
                        });
                    }
                }
            }

        },
        toggleCheckbox(val) {
            this.checkedStatus[val] = !this.checkedStatus[val];
        },
        notification(text, type) {

            const timeoutDuration = 6000;
            let id = Date.now();

            this.notifications.push({
                id: id,
                text: text,
                type: 'notification' + type,
                timeout: setTimeout(() => {
                    this.notifications = this.notifications.filter(notification => notification.id !== id);
                }, timeoutDuration),
            });
        },
        developerMode(val) {
            if (val) {
                clicksound("click");

                if (val == 'runcmd') {
                    this.runcmd = !this.runcmd;

                } else if (val == 'copyvector3') {
                    postNUI("selectPlayerValue", {
                        name: 'copyvector3',
                        plyid: 0,
                    });
                } else if (val == 'copyvector4') {
                    postNUI("selectPlayerValue", {
                        name: 'copyvector4',
                        plyid: 0,
                    });
                } else if (val == 'copyheading') {
                    postNUI("selectPlayerValue", {
                        name: 'copyheading',
                        plyid: 0,
                    });
                } else if (val == 'copyxyzh') {
                    postNUI("selectPlayerValue", {
                        name: 'copyxyzh',
                        plyid: 0,
                    });
                }
            }
        },
        handleMouseOver() {
            if (!this.isDragInitialized) {
                this.isDragInitialized = true;
                setTimeout(() => {

                    this.InitDrag();
                }, 100);
            }
        },
        handleMouseLeave() {
            if (this.isDragInitialized) {
                this.isDragInitialized = false;
                setTimeout(() => {
                    if ($('.dragPanel').data('ui-draggable')) {
                        $('.dragPanel').draggable('destroy');
                    }
                }, 50);
            }
        },

        InitDrag() {

            if (!this.isDragInitialized) return;
            $('.dragPanel').draggable({
                helper: "clone",
                revertDuration: 0,
                revert: false,
                cancel: ".item-nodrag",
                containment: "body",
                scroll: false,
                start: function (event, ui) { },
                drag: function (event, ui) { },
                stop: (event, ui) => {
                    let left = ui.position.left;
                    let top = ui.position.top;
                    let type = $(event.target).attr('data-type');
                    this.positionsData[type] = {
                        left: `${left}px`,
                        top: `${top}px`,
                        position: `absolute`
                    };

                }
            });
        },

        sendAttrValueSpectateMenu(val) {
            clicksound("click");
            if (val == "cancel") {
                this.spectateModel = false;
                this.spectateModelLet = false;
                this.banPanel = false;
                return;
            }
            if (this.banPanel) {
                this.banPanel = false;
                return;
            }

            if (this.spectateModelLet && this.spectateModelLet == "ban" && !this.banPanel) {
                this.banPanel = true;
            }
            let name = null;

            if (this.spectateModel == 'spectatepm') {
                name = "pm"
            }
            if (this.spectateModel == 'spectatewarn') {

                postNUI("setPlayerAttr", {
                    attr: 'warnbackground',
                    value: this.playerAttrModel,
                    plyid: this.playerSelect.id,
                });
                this.playerAttrModel = "";
                return;
            }
            if (this.spectateModel == 'spectatekick') {

                postNUI("setPlayerAttr", {
                    attr: 'kickbackground',
                    value: this.playerAttrModel,
                    plyid: this.playerSelect.id,
                });
                this.playerAttrModel = "";
                return;
            }

            if (this.spectateModel == 'spectateperma') {

                postNUI("setPlayerAttr", {
                    attr: 'permabackground',
                    value: this.playerAttrModel,
                    plyid: this.playerSelect.id,
                });
                this.playerAttrModel = "";
                this.banPlayerValue = false;
                return;
            }

            if (this.spectateModel == 'spectatejail') {
                this.jailPlayerValue = true;
                return;
            }

            postNUI("selectPlayerValue", {
                name: name,
                plyid: this.playerSelect.id,
                value: this.playerAttrModel
            });
            this.playerAttrModel = "";
            this.banPlayerValue = false;

        },
        spectateModelValue(val) {
            if (val) {
                if (val == "return") {
                    // this.stafMenuPage = false;
                    this.spectateModel = false;
                    this.spectateModelLet = false;
                    setTimeout(() => {
                        this.spectateMenu = false;
                    }, 100);
                    setTimeout(() => {
                        this.stafMenuPage = "main";
                    }, 1200);
                    postNUI("defaultSpec");
                    return;
                }
                clicksound("click");
                if (this.spectateModelLet == val) {
                    this.spectateModel = false;
                    this.spectateModelLet = false;
                    return;
                }
                if (!this.spectateModel) {
                    this.spectateModel = "spectate" + val;
                    this.spectateModelLet = val;
                    return;
                } else {
                    this.spectateModel = false;
                    setTimeout(() => {
                        this.spectateModel = "spectate" + val;
                        this.spectateModelLet = val;
                    }, 1000);
                }
            }
        },
        sendAttrData(attr, plyid) {
            if (!attr || this.playerAttrModel.length == 0 || !plyid) {
                this.forCopiedDiscordEtc = 'Input is not a empty!';
                setTimeout(() => {
                    this.forCopiedDiscordEtc = false;
                }, 1500);
                return;
            }

            clicksound("click");

            let isBackgroundAttr = ['banbackground', 'jailbackground'].includes(attr);

            if (isBackgroundAttr) {
                if (attr == 'banbackground') {
                    this.banPlayerValue = true;
                } else if (attr == 'jailbackground') {
                    this.jailPlayerValue = true;
                }
                banTimesMessage = this.playerAttrModel;
            } else {
                postNUI("setPlayerAttr", {
                    attr: attr,
                    value: this.playerAttrModel,
                    plyid: plyid
                });
                this.playerAttrModel = "";
            }
        },

        banPlayerTime(val, type) {
            clicksound("click");
            for (let key in this.banPlayerValueCache) {
                this.banPlayerValueCache[key] = false;
            }

            this.banPlayerValueCache[`${val}${type}`] = !this.banPlayerValueCache[`${val}${type}`];
            banTimesValue = val;
            banTimesType = type;

        },
        handleInputClick() {
            for (let key in this.banPlayerValueCache) {
                this.banPlayerValueCache[key] = false;
            }
            banTimesValue = '';
            banTimesType = '';
        },
        bannedSelectPlayer() {
            if (!this.playerSelect.id) return;

            clicksound("click");

            let banType = 'day';

            if (this.playerSelectInputDayModel.length > 0 && this.playerSelectInputHoursModel.length > 0) {
                this.forCopiedDiscordEtc = 'You can only select one!';
                this.banPlayerValue = false;
                setTimeout(() => {
                    this.forCopiedDiscordEtc = false;
                }, 1500);
                return;
            }

            if (this.playerSelectInputHoursModel.length > 0) {
                banType = 'hour';
                banTimesValue = this.playerSelectInputHoursModel;
            } else if (this.playerSelectInputDayModel.length > 0) {
                jailType = 'day';
                banTimesValue = this.playerSelectInputDayModel;
            } else if (this.playerSelectInputDayModel.length == 0 && this.playerSelectInputHoursModel.length == 0) {
                banType = banTimesType;
            }

            postNUI("playerBanned", {
                playerId: this.playerSelect.id,
                reason: banTimesMessage,
                time: banTimesValue,
                type: banType
            });

            this.banPlayerValue = false;
            this.playerStateAttributeValue = false;
        },

        sendJailPlayer() {


            if (!this.playerSelect.id) return;

            clicksound("click");

            let jailType = 'hour';

            if (this.playerSelectInputDayModel.length > 0 && this.playerSelectInputHoursModel.length > 0) {
                this.jailPlayerValue = false;
                this.forCopiedDiscordEtc = 'You can only select one!';
                setTimeout(() => {
                    this.forCopiedDiscordEtc = false;
                }, 1500);
                return;
            }

            if (this.playerSelectInputHoursModel.length > 0) {
                jailType = 'min';
                banTimesValue = this.playerSelectInputHoursModel;
            } else if (this.playerSelectInputDayModel.length > 0) {
                jailType = 'hour';
                banTimesValue = this.playerSelectInputDayModel;
            } else if (this.playerSelectInputDayModel.length == 0 && this.playerSelectInputHoursModel.length == 0) {
                jailType = banTimesType;
            }

            postNUI("playerJail", {
                playerId: this.playerSelect.id,
                reason: banTimesMessage,
                time: banTimesValue,
                type: jailType
            });

            this.jailPlayerValue = false;
            this.playerStateAttributeValue = false;
        },
        closeBanMenu() {
            clicksound("click");
            this.banPlayerValue = false;
            this.jailPlayerValue = false;
        },
        sendChatAdminMessage() {
            if (this.adminChatModel.length > 0) {
                clicksound("click");
                postNUI("chatAdminMessage", this.adminChatModel);
                this.adminChatModel = "";
            }
        },
        copyId(val, text) {
            clicksound("click");
            this.forCopiedDiscordEtc = val + 'Copied.';
            staffClipToBoard(text);
            setTimeout(() => {
                this.forCopiedDiscordEtc = false;
            }, 1500);
        },

        resetPlayerSelection() {
            for (let key in this.playerSelectButton) {
                this.playerSelectButton[key] = false;
            }
            this.playerSelect = false;
            this.playerStateAttributeValue = false;
            this.forPlayerInteraction = false;
            this.setPlayerStateAttributeValue = false;
        },

        setPlayerSelection(value) {
            this.playerSelect = false
           
            this.playerSelect = value;
            this.forPlayerInteraction = false;
            this.checkPlayerPermissionChangeTable(this.playerSelect.rankname);
            this.playerSelectButton[value.id] = !this.playerSelectButton[value.id];
        },

        getPlayerScoreBoardData(value) {
       
            if (value) {
                clicksound("click");
                if (this.bannedButton) {
                    postNUI("openPlayerBan", {
                        identifier: value.identifier
                    });
                    return;
                }
                if (value.id == this.playerSelect.id) {
                    this.resetPlayerSelection();
                } else {
                    if (!this.playerSelect.id) {
                        this.resetPlayerSelection();
                        setTimeout(() => {
                            this.setPlayerSelection(value);
                        }, 100);
                        return;
                    } else {
                        this.resetPlayerSelection();
                        setTimeout(() => {
                            this.setPlayerSelection(value);
                        }, 100);
                    }

                }
            }
        },

        checkPlayerPermissionChangeTable(rankname) {
                
         
            const permissionMapping = {
                'staff':        { perm: 'givestaff', labelRemove: this.locale.removestaff, labelGive: this.locale.givestaff },
                'admin':        { perm: 'giveadmin', labelRemove: this.locale.removeadmin, labelGive: this.locale.giveadmin },
                'superadmin':   { perm: 'givesuperadmin', labelRemove: this.locale.removesadmin, labelGive: this.locale.givesadmin },
                'vip':          { perm: 'givevip',       labelRemove: this.locale.removevip, labelGive: this.locale.givevip },
           
            };

            if(rankname !== 'user' && rankname !== 'owner'  ){
                let permissionInfo = permissionMapping[rankname];
            
                if (permissionInfo) {
            
                    this.forPlayerAdminPermissions.forEach((element, index) => {
                        
                        
                      
                        if (element.name == permissionInfo.perm) {
                         
                            element.label = permissionInfo.labelRemove;
                            this.interactionAdminPermissions[permissionInfo.perm].placeholder = this.locale.textPlayer2 + permissionInfo.perm + ' ?';
                        
                        }else if(element.name == 'givestaff'){
                       
                            element.label = this.locale.givestaff;
                            this.interactionAdminPermissions[permissionInfo.perm].placeholder = this.locale.textPlayer2 + permissionInfo.perm + ' ?';
                        }else if(element.name == 'giveadmin'){
                         
                            element.label = this.locale.giveadmin;
                            this.interactionAdminPermissions[permissionInfo.perm].placeholder = this.locale.textPlayer2 + permissionInfo.perm + ' ?';
                        }else if(element.name == 'givesuperadmin'){
                         
                            element.label = this.locale.givesadmin;
                            this.interactionAdminPermissions[permissionInfo.perm].placeholder = this.locale.textPlayer2 + permissionInfo.perm + ' ?';
                        }else if(element.name == 'givevip'){
                          
                            element.label = this.locale.givevip;
                            this.interactionAdminPermissions[permissionInfo.perm].placeholder = this.locale.textPlayer2 + permissionInfo.perm + ' ?';
                        }else{
                            if (element.name == 'givestaff' || element.name == 'giveadmin' || element.name == 'givesuperadmin' || element.name == 'givevip') {
                                if (element.name == permissionInfo.perm) {
                          
                                    element.label = permissionInfo.labelRemove;
                                    this.interactionAdminPermissions[permissionInfo.perm].placeholder = this.locale.textPlayer2 + permissionInfo.perm + ' ?';
                                }
                            }
                        }
                    });
                }
            }else{
                for(let rank in permissionMapping){
                    let permissionInfo = permissionMapping[rank];
                    if (permissionInfo) {
                        this.updatePermissionTable2(permissionInfo.perm, permissionInfo.labelGive);
                    }
                }
            }
        
    },
        updatePermissionTable2(permName, giveLabel) {
            this.forPlayerAdminPermissions.forEach((element, index) => {
                if (element.name == permName) {
                 
                        element.label = giveLabel;
               
                    
                }
            });
        },
        selectPlayerAdminOptions(name, label) {
            clicksound("click");

            if (name) {
                if (this.stafMenuPage == 'fastpanel') {

                    if (this.fastPanelAdminPermissions[name]) {
                        this.forPlayerInteraction = this.fastPanelAdminPermissions[name];
                    } else {

                        let adminPermTable = ["noclip", "revivepanel", "invisible", "healpanel", "giveped", "godmode", "repairvehicle", "showname", "showplayerblip", "tpmarker"]
                        let value = null;
                        let playerId = this.selfStaffData.id;
                        for (let key in adminPermTable) {
                            if (adminPermTable[key] == name) {
                                if (name == "showname") {
                                    this.showName = !this.showName;
                                    value = this.showName;
                                } else if (name == 'showplayerblip') {
                                    this.showBlip = !this.showBlip;
                                    value = this.showBlip;
                                }
                                postNUI("selectPlayerValue", {
                                    name: name,
                                    plyid: playerId,
                                    value: value
                                });
                                return;
                            }
                        }

                    }
                    return;
                };


                if (this.interactionAdminPermissions[name]) {
                    this.forPlayerInteraction = this.interactionAdminPermissions[name];

                } else {

                    this.forPlayerInteraction = false;

                    if (this.playerSelect) {
                        if (name == 'godmode') {
                            postNUI("selectPlayerValue", {
                                name: name,
                                plyid: this.selfStaffData.id
                            });
                            return;
                        }
                        postNUI("selectPlayerValue", {
                            name: name,
                            plyid: this.playerSelect.id
                        });
                        return;
                    }


                    let adminPermTable = ["devtools", "giveped", "clearvehicle", "cleararea", "allrevive", "noclip", "revivepanel", "healpanel", "repairvehicle", "godmode", "invisible", "showname", "showplayerblip", "tpmarker"]
                    let value = null;
                    let playerId = this.selfStaffData.id;
                    for (let key in adminPermTable) {
                        if (adminPermTable[key] == name) {

                            if (name == "showname") {
                                this.showName = !this.showName;
                                value = this.showName;
                            } else if (name == 'showplayerblip') {
                                this.showBlip = !this.showBlip;
                                value = this.showBlip;
                            }
                            postNUI("selectPlayerValue", {
                                name: name,
                                plyid: playerId,
                                value: value
                            });
                            return;
                        }
                    }

                }

            }
        },
        playerInteractionSubmit(name) {

            if (name == 'giveitem' && this.selfStaffData.id && !this.playerSelect.id) {
                clicksound("click");

                if (this.selfStaffData && this.setPlayerStateInput.length > 0 && this.setPlayerStateInput2.length > 0) {
                    const integerValue = parseInt(this.setPlayerStateInput2);

                    if (!isNaN(integerValue)) {
                        postNUI("selectPlayerValue", {
                            name: name,
                            plyid: this.selfStaffData.id,
                            value: {
                                item: this.setPlayerStateInput,
                                count: this.setPlayerStateInput2
                            }
                        });
                        this.setPlayerStateInput = "";
                        this.setPlayerStateInput2 = "";
                        this.forPlayerInteraction = false;
                    } else {
                        this.forCopiedDiscordEtc = this.locale.inputisnot;
                        setTimeout(() => {
                            this.forCopiedDiscordEtc = false;
                        }, 1500);
                    }

                } else {
                    this.forCopiedDiscordEtc = this.locale.inputisempty;

                    setTimeout(() => {
                        this.forCopiedDiscordEtc = false;
                    }, 1500);


                }
                return;
            } else if (name == 'announce') {
                clicksound("click");
                if (this.selfStaffData && this.setPlayerStateInput.length > 0) {
                    postNUI("selectPlayerValue", {
                        name: name,
                        plyid: this.selfStaffData.id,
                        value: this.setPlayerStateInput,
                    });
                    this.setPlayerStateInput = "";
                    this.setPlayerStateInput2 = "";
                    this.forPlayerInteraction = false;



                } else {
                    this.forCopiedDiscordEtc = this.locale.inputisempty;

                    setTimeout(() => {
                        this.forCopiedDiscordEtc = false;
                    }, 1500);


                }
                return;
            } else if (name == 'givevehicle' && this.selfStaffData.id && !this.playerSelect.id) {
                if (this.selfStaffData && this.setPlayerStateInput.length > 0) {
                    if (this.setPlayerStateInput.length > 0) {

                        postNUI("selectPlayerValue", {
                            name: name,
                            plyid: this.selfStaffData.id,
                            value: this.setPlayerStateInput
                        });
                        this.setPlayerStateInput = "";
                        this.forPlayerInteraction = false;
                    } else {
                        this.forCopiedDiscordEtc = this.locale.inputisempty;

                        setTimeout(() => {
                            this.forCopiedDiscordEtc = false;
                        }, 1500);
                    }
                }
                return;
            } else if (name == 'givevehicledatabase' && this.selfStaffData.id && !this.playerSelect.id) {
                if (this.selfStaffData && this.setPlayerStateInput.length > 0) {
                    if (this.setPlayerStateInput.length > 0) {

                        postNUI("selectPlayerValue", {
                            name: name,
                            plyid: this.selfStaffData.id,
                            value: this.setPlayerStateInput
                        });
                        this.setPlayerStateInput = "";
                        this.forPlayerInteraction = false;
                    } else {
                        this.forCopiedDiscordEtc = this.locale.inputisempty;

                        setTimeout(() => {
                            this.forCopiedDiscordEtc = false;
                        }, 1500);
                    }
                }
                return;
            }

            if (this.playerSelect && name) {
                // setPlayerStateInput
                clicksound("click");
                if (name == "giveitem") {
                    if (this.setPlayerStateInput.length > 0 && this.setPlayerStateInput2.length > 0) {
                        const integerValue = parseInt(this.setPlayerStateInput2);
                        if (!isNaN(integerValue)) {
                            postNUI("selectPlayerValue", {
                                name: name,
                                plyid: this.playerSelect.id,
                                value: {
                                    item: this.setPlayerStateInput,
                                    count: this.setPlayerStateInput2
                                }
                            });
                            this.setPlayerStateInput = "";
                            this.setPlayerStateInput2 = "";
                            this.forPlayerInteraction = false;
                        } else {
                            this.forCopiedDiscordEtc = this.locale.inputisnot;
                            setTimeout(() => {
                                this.forCopiedDiscordEtc = false;
                            }, 1500);
                        }
                    } else {
                        this.forCopiedDiscordEtc = this.locale.inputisempty;

                        setTimeout(() => {
                            this.forCopiedDiscordEtc = false;
                        }, 1500);

                    }
                } else if (name == 'setjob') {
                    if (this.setPlayerStateInput.length > 0 && this.setPlayerStateInput2.length > 0) {
                        const integerValue = parseInt(this.setPlayerStateInput2);
                        if (!isNaN(integerValue)) {
                            postNUI("selectPlayerValue", {
                                name: name,
                                plyid: this.playerSelect.id,
                                value: {
                                    jobname: this.setPlayerStateInput,
                                    jobgrade: this.setPlayerStateInput2
                                }
                            });
                            this.setPlayerStateInput = "";
                            this.setPlayerStateInput2 = "";
                            this.forPlayerInteraction = false;
                        } else {
                            this.forCopiedDiscordEtc = this.locale.inputisnot;
                            setTimeout(() => {
                                this.forCopiedDiscordEtc = false;
                            }, 1500);
                        }
                    } else {
                        this.forCopiedDiscordEtc = this.locale.inputisempty;

                        setTimeout(() => {
                            this.forCopiedDiscordEtc = false;
                        }, 1500);

                    }

                } else if (name == 'givecash') {
                    if (this.setPlayerStateInput.length > 0) {
                        const integerValue = parseInt(this.setPlayerStateInput);
                        if (!isNaN(integerValue)) {

                            postNUI("selectPlayerValue", {
                                name: name,
                                plyid: this.playerSelect.id,
                                value: this.setPlayerStateInput
                            });
                            this.setPlayerStateInput = "";
                            this.forPlayerInteraction = false;
                        } else {
                            this.forCopiedDiscordEtc = this.locale.inputisnot;
                            setTimeout(() => {
                                this.forCopiedDiscordEtc = false;
                            }, 1500);
                        }
                    } else {
                        this.forCopiedDiscordEtc = this.locale.inputisempty;
                        setTimeout(() => {
                            this.forCopiedDiscordEtc = false;
                        }, 1500);
                    }

                } else if (name == 'givebank') {
                    if (this.setPlayerStateInput.length > 0) {
                        const integerValue = parseInt(this.setPlayerStateInput);
                        if (!isNaN(integerValue)) {

                            postNUI("selectPlayerValue", {
                                name: name,
                                plyid: this.playerSelect.id,
                                value: this.setPlayerStateInput
                            });
                            this.setPlayerStateInput = "";
                            this.forPlayerInteraction = false;
                        } else {
                            this.forCopiedDiscordEtc = this.locale.inputisnot;
                            setTimeout(() => {
                                this.forCopiedDiscordEtc = false;
                            }, 1500);
                        }
                    } else {
                        this.forCopiedDiscordEtc = this.locale.inputisempty;
                        setTimeout(() => {
                            this.forCopiedDiscordEtc = false;
                        }, 1500);
                    }

                } else if (name == 'pm') {
                    if (this.setPlayerStateInput.length > 0) {

                        postNUI("selectPlayerValue", {
                            name: name,
                            plyid: this.playerSelect.id,
                            value: this.setPlayerStateInput
                        });
                        this.setPlayerStateInput = "";
                        this.forPlayerInteraction = false;
                    } else {
                        this.forCopiedDiscordEtc = this.locale.inputisempty;

                        setTimeout(() => {
                            this.forCopiedDiscordEtc = false;
                        }, 1500);
                    }
                    return;
                } else if (name == 'givevehicle') {
                    if (this.setPlayerStateInput.length > 0) {

                        postNUI("selectPlayerValue", {
                            name: name,
                            plyid: this.playerSelect.id,
                            value: this.setPlayerStateInput
                        });
                        this.setPlayerStateInput = "";
                        this.forPlayerInteraction = false;
                    } else {
                        this.forCopiedDiscordEtc = this.locale.inputisempty;

                        setTimeout(() => {
                            this.forCopiedDiscordEtc = false;
                        }, 1500);
                    }
                    return;
                } else if (name == 'givevehicledatabase') {
                    if (this.setPlayerStateInput.length > 0) {

                        postNUI("selectPlayerValue", {
                            name: name,
                            plyid: this.playerSelect.id,
                            value: this.setPlayerStateInput
                        });
                        this.setPlayerStateInput = "";
                        this.forPlayerInteraction = false;
                    } else {
                        this.forCopiedDiscordEtc = this.locale.inputisempty;

                        setTimeout(() => {
                            this.forCopiedDiscordEtc = false;
                        }, 1500);
                    }
                    return;
                } else {

                    if (name == 'givestaff') {
                        if (this.playerSelect.rankname == 'staff') {
                            if (this.playerSelect.id == this.selfStaffData.id) {
                                postNUI("selectPlayerValue", {
                                    name: 'removestaff',
                                    plyid: this.playerSelect.id
                                });
                            } else {
                                this.checkPlayerPermissionRemoveChangeTable('staff');
                                postNUI("selectPlayerValue", {
                                    name: 'removestaff',
                                    plyid: this.playerSelect.id
                                });
                            }

                        } else {
                            postNUI("selectPlayerValue", {
                                name: name,
                                plyid: this.playerSelect.id
                            });
                        }
                    } else if (name == 'giveadmin') {
                      
                    
                        if (this.playerSelect.rankname == 'admin') {
                            if (this.playerSelect.id == this.selfStaffData.id) {
                                postNUI("selectPlayerValue", {
                                    name: 'removestaff',
                                    plyid: this.playerSelect.id
                                });
                            } else {
                            
                                this.checkPlayerPermissionRemoveChangeTable('admin');
                                postNUI("selectPlayerValue", {
                                    name: 'removestaff',
                                    plyid: this.playerSelect.id
                                });
                            }

                        } else {
                         
                            postNUI("selectPlayerValue", {
                                name: name,
                                plyid: this.playerSelect.id
                            });
                        }
                    } else if (name == 'givesuperadmin') {
                        if (this.playerSelect.rankname == 'superadmin') {
                            if (this.playerSelect.id == this.selfStaffData.id) {
                                postNUI("selectPlayerValue", {
                                    name: 'removestaff',
                                    plyid: this.playerSelect.id
                                });
                            } else {
                                this.checkPlayerPermissionRemoveChangeTable('superadmin');
                                postNUI("selectPlayerValue", {
                                    name: 'removestaff',
                                    plyid: this.playerSelect.id
                                });
                            }
                        } else {
                            postNUI("selectPlayerValue", {
                                name: name,
                                plyid: this.playerSelect.id
                            });
                        }
                    } else if (name == 'givevip') {
                        if (this.playerSelect.rankname == 'vip') {
                            if (this.playerSelect.id == this.selfStaffData.id) {
                                postNUI("selectPlayerValue", {
                                    name: 'removestaff',
                                    plyid: this.playerSelect.id
                                });
                            } else {
                                this.checkPlayerPermissionRemoveChangeTable('vip');

                                postNUI("selectPlayerValue", {
                                    name: 'removestaff',
                                    plyid: this.playerSelect.id
                                });
                            }



                        } else {
                            postNUI("selectPlayerValue", {
                                name: name,
                                plyid: this.playerSelect.id
                            });
                        }
                    } else {
                        postNUI("selectPlayerValue", {
                            name: name,
                            plyid: this.playerSelect.id
                        });
                    }

                    // postNUI("selectPlayerValue", {
                    //     name: name,
                    //     plyid: this.playerSelect.id
                    // });
                    this.forPlayerInteraction = false;
                }

            }
        },
        checkPlayerPermissionRemoveChangeTable(rankname) {
            if (rankname) {
          
                const rankMap = {
                    'staff': 'staff',
                    'admin': 'admin',
                    'superadmin': 'superadmin',
                    'vip': 'vip'
                };

                const rankLabelMap = {
                    'staff': 'Give Staff',
                    'admin': 'Give Admin',
                    'superadmin': 'Give SAdmin',
                    'vip': 'Give Vip'
                };

                const permissionName = rankMap[rankname];
                const permissionLabel = rankLabelMap[rankname];

                this.forPlayerAdminPermissions.forEach((element, index) => {
                    if (element.name == permissionName) {
                        element.label = permissionLabel;
                    }
                });
            }
        },
        changeWeather(value) {
            if (value) {
                clicksound("click");
                postNUI("selectPlayerValue", {
                    name: 'weather',
                    plyid: this.selfStaffData.id,
                    value: value.name
                });
            }

        },
        freezeTimeButton(value) {
            clicksound("click");
            postNUI("selectPlayerValue", {
                name: 'freezetime',
                plyid: this.selfStaffData.id,
                value: value
            });



        },
        setTimeButton() {
            clicksound("click");

            if (this.timeValueInput.length > 0) {
                postNUI("selectPlayerValue", {
                    name: 'time',
                    plyid: this.selfStaffData.id,
                    value: this.timeValueInput
                });

                this.timeValueInput = "";
            } else {
                if (this.playerSelect) {
                    this.forCopiedDiscordEtc = this.locale.inputisempty;

                    setTimeout(() => {
                        this.forCopiedDiscordEtc = false;
                    }, 1500);
                } else {
                    this.forCopiedDiscordEtcAlt = this.locale.inputisempty;

                    setTimeout(() => {
                        this.forCopiedDiscordEtcAlt = false;
                    }, 1500);
                }

            }
        },
        chageTime(value) {
            if (value) {
                clicksound("click");
                postNUI("selectPlayerValue", {
                    name: 'time',
                    plyid: this.selfStaffData.id,
                    value: value.name
                });
            }
        },

        cancelInteractionMenu() {
            clicksound("click");
            this.forPlayerInteraction = false;
            this.setPlayerStateInput = "";
            this.setPlayerStateInput2 = "";
        },
        keyHandler(e) {
            if (e.which == 27) {
                this.backToStatePage();
                this.stafMenuPage = false;
                this.forPlayerInteraction = false;
                this.playerSelect = false;
                for (let key in this.scoreBoardAnimButton) {
                    this.scoreBoardAnimButton[key] = false;
                }
                postNUI("closeAdminMenu");
            }
        },
        scoreBoardChangeResult(value) {
            if (value) {
                this.bannedButton = false;
                clicksound("click");

                if (value === "search") {
                    for (let key in this.scoreBoardAnimButton) {
                        this.scoreBoardAnimButton[key] = false;
                    }

                    this.scoreBoardAnimActiveButton = "search";
                    this.filterScoreBoardData = [...this.scoreBoardData];
                    return this.scoreBoardAnimActiveButtonSearchBar = !this.scoreBoardAnimActiveButtonSearchBar;
                }

                if (value === 'banned') {
                    this.handleBannedButton();
                } else if (value === "all") {
                    this.filterScoreBoardData = [...this.scoreBoardData];
                } else if (value === "staff") {
                    this.filterScoreBoardData = this.scoreBoardData.filter(player => ['staff', 'admin', 'superadmin', 'owner'].includes(player.rankname));
                } else {
           
                    this.filterScoreBoardData = this.scoreBoardData.filter(player => player.jobname === value);
                }

                this.scoreBoardAnimActiveButton = value;

                for (let key in this.scoreBoardAnimButton) {
                    this.scoreBoardAnimButton[key] = false;
                }
                this.scoreBoardAnimButton[value] = !this.scoreBoardAnimButton[value];
            }
        },

        handleBannedButton() {
            this.filterScoreBoardData = []
            this.bannedButton = true;
            this.playerSelect = false;

            postNUI("getBannedData", {});

            // this.filterScoreBoardData = BannedData;
        },
        changeScoreBoardBackground(name) {
            if (name !== this.scoreBoardAnimActiveButton) {
                return { background: "none" };
            }

            const colorMap = {
                "staff": { background: "rgba(50, 189, 64, 0.06)", "border-bottom": "2px solid #32BD40" },
                "police": { background: "rgba(0, 0, 255, 0.06)", "border-bottom": "2px solid #0000FF" },
                "ambulance": { background: "rgba(255, 101, 184, 0.06)", "border-bottom": "2px solid #FF65B8" },
                "mechanic": { background: "rgba(172, 67, 255, 0.06)", "border-bottom": "2px solid #AC43FF" },
                "search": { background: "rgba(255, 255, 255, 0.06)", "border-bottom": "2px solid white" },
                "banned": { background: "rgba(255, 0, 0, 0.06)", "border-bottom": "2px solid #FF0000" }
            };

            return colorMap[name] || { background: "none" };
        },
        getRankColor(rank) {
            const colorMap = {
                "staff": { color: "#32BD40" },
                "admin": { color: "#BD5C32" },
                "superadmin": { color: "#FF5555" },
                "owner": { color: "#64F6FF" }
            };

            return colorMap[rank] || { color: "white" };
        },

        getStaffTextColor(name) {
            return this.getRankColor(name);
        },

        selfStaffDataRankcolor(rank) {
            return this.getRankColor(rank);
        },

        getRankBorderColor(rank) {
            const borderColorMap = {
                "staff": { border: "2px solid #32BD40" },
                "admin": { border: "2px solid #BD5C32" },
                "superadmin": { border: "2px solid #FF5555" },
                "owner": { border: "2px solid #64F6FF" }
            };

            return borderColorMap[rank] || { border: "2px solid white" };
        },

        selfStaffDataBorderRankcolor(rank) {
            return this.getRankBorderColor(rank);
        },

        resetState() {
            this.playerStateAttributeValue = false;
            this.playerStatePageHeader = "";
            this.setPlayerStateAttributeValue = false;
            this.setPlayerStatePageBackground = false;
            this.setPlayerStatePageHeader = "";
            this.vForValue = false;

        },

        playerState(value, label) {
            clicksound();
            if (value) {
                this.playerStateAttributeValue = value + "background";
                this.playerStatePageHeader = label;
                this.setPlayerStateAttributeValue = false;
            } else {
                this.resetState();
            }
        },

        setPlayerState(value, label) {
            clicksound("click");
            if (value) {
                this.resetState();
                this.vForValue = value;
                this.setPlayerStateAttributeValue = value + "textbox";
                this.setPlayerStatePageBackground = value + "playerbg";
                this.setPlayerStatePageHeader = label;
            }
        },

        backToStatePage() {
            clicksound("click");
            this.resetState();
        },
        runCommand() {
            this.output.push({
                command: this.command
            });

            postNUI("selectPlayerValue", {
                name: 'runcommand',
                plyid: this.selfStaffData.id,
                value: this.command
            });
            this.command = "";

        },
        playerStateAttributeValueCancel() {
            clicksound("click");
            this.playerStateAttributeValue = false;
            this.playerStatePageHeader = "";
            this.setPlayerStateAttributeValue = false;
            this.setPlayerStatePageBackground = false;
            this.setPlayerStatePageHeader = "";
        },
        cancelWeatherMenu() {
            clicksound("click");
            this.forPlayerInteraction = false;
        }
    },
    computed: {
        filterByTermScoreBoard() {
            if (this.scoreBoardSearchBarInputValue.length > 0) {
                return this.filterScoreBoardData.filter(name => {
                    return (
                        name.id.toString().toLowerCase().includes(this.scoreBoardSearchBarInputValue.toLowerCase()) ||
                        name.name.toLowerCase().includes(this.scoreBoardSearchBarInputValue.toLowerCase()) ||
                        name.job.toLowerCase().includes(this.scoreBoardSearchBarInputValue.toLowerCase())
                    );
                });
            } else {
                return this.filterScoreBoardData;
            }
        },
        playerAttributeLength() {
            return attribute => {
                if (this.playerSelect.attr && this.playerSelect.attr[attribute]) {
                    return this.playerSelect.attr[attribute].length;
                }
                return 0;
            };
        },

    },

    // mounted() {
    //     // // this.playerStateAttributeValue = 'warnbackground';
    //     // this.setPlayerStateAttributeValue = "warn" + "textbox";
    //     // this.setPlayerStatePageBackground = "warn" + "playerbg";
    //     // this.setPlayerStatePageHeader = "Warn";

    //     // this.stafMenuPage = "main";

    //     // // this.menuVisible = true;
    //     window.addEventListener('keyup', this.keyHandler);
    // },
    watch: {


    },

    beforeDestroy() { },
    mounted() {
        // this.filterScoreBoardData = [...this.scoreBoardData];
        window.addEventListener("keyup", this.keyHandler);
        window.addEventListener("message", event => {
            switch (event.data.action) {
                case "send_response":
                    postNUI("GetResponse");
                    break;
                case "openAdminMenu":
                    clicksound("openmenu");
                   
                    (this.stafMenuPage = "main"), (this.scoreBoardData = event.data.players), (this.filterScoreBoardData = [...this.scoreBoardData]);
                    this.selfStaffData = event.data.players.find(player => parseInt(player.id) == parseInt(event.data.myId));
       
                    this.onlineStaff = event.data.onlineAdmin;
                    this.scoreBoardChangeResult('all')
                    this.mainSettings[0].value = this.filterScoreBoardData.length

                    break;
                case "openFastPanel":
                    clicksound("openmenu");
                    if (this.stafMenuPage == 'mainmenu') {
                        (this.stafMenuPage = "fastpanel");
                    } else {
                        (this.stafMenuPage = "fastpanel");
                    }
                    this.selfStaffData = event.data.players.find(player => parseInt(player.id) == parseInt(event.data.myId));
                    break;
                case "scoreBoardSearchIcons":
                    this.scoreBoardSearchIcon = event.data.searchBarIcon;
                    this.locale = event.data.locales;
                    this.serverlogo = event.data.serverLogo;
                    this.playerStateAttribute = event.data.attribute;
                    this.adminPermissions = event.data.adminperm;
                    this.forPlayerAdminPermissions = event.data.playerperm;
                    this.serverAdminSettings = event.data.serverAdminSet;
                    this.devtoolsMenu = event.data.devtoolsText;
                    this.spectateButtons = event.data.spectateText;

                    this.fastPanelAdminPermissions.giveitempanel.placeholder = event.data.locales.itemcode;
                    this.fastPanelAdminPermissions.giveitempanel.placeholder2 = event.data.locales.amount;
                    this.fastPanelAdminPermissions.giveitempanel.label = event.data.locales.giveitem;
                    this.fastPanelAdminPermissions.giveitempanel.text1 = event.data.locales.giveitem;
                    this.fastPanelAdminPermissions.giveitempanel.text2 = event.data.locales.cancel2;

                    this.fastPanelAdminPermissions.givevehiclepanel.placeholder = event.data.locales.vehiclename;
                    this.fastPanelAdminPermissions.givevehiclepanel.label = event.data.locales.givevehicle;
                    this.fastPanelAdminPermissions.givevehiclepanel.text1 = event.data.locales.givevehicle;
                    this.fastPanelAdminPermissions.givevehiclepanel.text2 = event.data.locales.givevehicletodatabase;
                    this.fastPanelAdminPermissions.givevehiclepanel.text3 = event.data.locales.cancel2;

                    this.interactionAdminPermissions.giveitem.placeholder = event.data.locales.itemcode;
                    this.interactionAdminPermissions.giveitem.placeholder2 = event.data.locales.amount;
                    this.interactionAdminPermissions.giveitem.label = event.data.locales.giveitem;
                    this.interactionAdminPermissions.giveitem.text1 = event.data.locales.giveitem;
                    this.interactionAdminPermissions.giveitem.text2 = event.data.locales.cancel2;

                    this.interactionAdminPermissions.giveitempanel.placeholder = event.data.locales.itemcode;
                    this.interactionAdminPermissions.giveitempanel.placeholder2 = event.data.locales.amount;
                    this.interactionAdminPermissions.giveitempanel.label = event.data.locales.giveitem;
                    this.interactionAdminPermissions.giveitempanel.text1 = event.data.locales.giveitem;
                    this.interactionAdminPermissions.giveitempanel.text2 = event.data.locales.cancel2;

                    this.interactionAdminPermissions.givemoney.placeholder = event.data.locales.amount;
                    this.interactionAdminPermissions.givemoney.label = event.data.locales.givemoney;
                    this.interactionAdminPermissions.givemoney.text1 = event.data.locales.givemoney;
                    this.interactionAdminPermissions.givemoney.text2 = event.data.locales.givebank;
                    this.interactionAdminPermissions.givemoney.text3 = event.data.locales.cancel2;

                    this.interactionAdminPermissions.setjob.placeholder = event.data.locales.jobname;
                    this.interactionAdminPermissions.setjob.placeholder2 = event.data.locales.grade;
                    this.interactionAdminPermissions.setjob.label = event.data.locales.setjob;
                    this.interactionAdminPermissions.setjob.text1 = event.data.locales.setjob;
                    this.interactionAdminPermissions.setjob.text2 = event.data.locales.cancel2;

                    this.interactionAdminPermissions.givevip.placeholder = event.data.locales.surevip;
                    this.interactionAdminPermissions.givevip.label = event.data.locales.setvip;
                    this.interactionAdminPermissions.givevip.text1 = event.data.locales.yessurevip;
                    this.interactionAdminPermissions.givevip.text2 = event.data.locales.cancel2;

                    // this.interactionAdminPermissions.givestaff.placeholder = event.data.locales.surestaff;
                    // this.interactionAdminPermissions.givestaff.label = event.data.locales.givestaff;
                    // this.interactionAdminPermissions.givestaff.text1 = event.data.locales.yessurestaff;
                    // this.interactionAdminPermissions.givestaff.text2 = event.data.locales.cancel2;

                    // this.interactionAdminPermissions.giveadmin.placeholder = event.data.locales.sureadmin;
                    // this.interactionAdminPermissions.giveadmin.label = event.data.locales.giveadmin;
                    // this.interactionAdminPermissions.giveadmin.text1 = event.data.locales.yessureadmin;
                    // this.interactionAdminPermissions.giveadmin.text2 = event.data.locales.cancel2;

                    // this.interactionAdminPermissions.givesuperadmin.placeholder = event.data.locales.suresuperadmin;
                    // this.interactionAdminPermissions.givesuperadmin.label = event.data.locales.givesuperadmin;
                    // this.interactionAdminPermissions.givesuperadmin.text1 = event.data.locales.yessuresuperadmin;
                    // this.interactionAdminPermissions.givesuperadmin.text2 = event.data.locales.cancel2;

                    this.interactionAdminPermissions.pm.placeholder = event.data.locales.sendmsg;
                    this.interactionAdminPermissions.pm.label = event.data.locales.sendpm;
                    this.interactionAdminPermissions.pm.text1 = event.data.locales.sendpm;
                    this.interactionAdminPermissions.pm.text2 = event.data.locales.cancel2;

                    this.interactionAdminPermissions.givevehicle.placeholder = event.data.locales.vehiclename;
                    this.interactionAdminPermissions.givevehicle.label = event.data.locales.givevehicle;
                    this.interactionAdminPermissions.givevehicle.text1 = event.data.locales.givevehicle;
                    this.interactionAdminPermissions.givevehicle.text2 = event.data.locales.givevehicletodatabase;
                    this.interactionAdminPermissions.givevehicle.text3 = event.data.locales.cancel2;

                    this.interactionAdminPermissions.givevehiclepanel.placeholder = event.data.locales.vehiclename;
                    this.interactionAdminPermissions.givevehiclepanel.label = event.data.locales.givevehicle;
                    this.interactionAdminPermissions.givevehiclepanel.text1 = event.data.locales.givevehicle;
                    this.interactionAdminPermissions.givevehiclepanel.text2 = event.data.locales.givevehicletodatabase;
                    this.interactionAdminPermissions.givevehiclepanel.text3 = event.data.locales.cancel2;

                    this.interactionAdminPermissions.announce.placeholder = event.data.locales.anntext;
                    this.interactionAdminPermissions.announce.label = event.data.locales.announcement;
                    this.interactionAdminPermissions.announce.text1 = event.data.locales.announce;
                    this.interactionAdminPermissions.announce.text2 = event.data.locales.cancel2;
                    
                    this.permissionSystem['warnAction'][0].label = event.data.locales.warn;
                    this.permissionSystem['warnAction'][1].label = event.data.locales.kicks;
                    this.permissionSystem['warnAction'][2].label = event.data.locales.adminjail;
                    this.permissionSystem['warnAction'][3].label = event.data.locales.bans2;
                    this.permissionSystem['warnAction'][4].label = event.data.locales.perma;

                    this.permissionSystem['ingameAction'][0].label = event.data.locales.spectate;
                    this.permissionSystem['ingameAction'][1].label = event.data.locales.revive;
                    this.permissionSystem['ingameAction'][2].label = event.data.locales.kill;
                    this.permissionSystem['ingameAction'][3].label = event.data.locales.freeze;
                    this.permissionSystem['ingameAction'][4].label = event.data.locales.goto;
                    this.permissionSystem['ingameAction'][5].label = event.data.locales.bring;
                    this.permissionSystem['ingameAction'][6].label = event.data.locales.markgps;
                    this.permissionSystem['ingameAction'][7].label = event.data.locales.giveitem;
                    this.permissionSystem['ingameAction'][8].label = event.data.locales.givecash;
                    this.permissionSystem['ingameAction'][9].label = event.data.locales.givebank;
                    this.permissionSystem['ingameAction'][10].label = event.data.locales.devtooltext;
                    this.permissionSystem['ingameAction'][11].label = event.data.locales.noclip;
                    this.permissionSystem['ingameAction'][12].label = event.data.locales.godmode;
                    this.permissionSystem['ingameAction'][13].label = event.data.locales.heal;
                    this.permissionSystem['ingameAction'][14].label = event.data.locales.invisible;
                    this.permissionSystem['ingameAction'][15].label = event.data.locales.showName;
                    this.permissionSystem['ingameAction'][16].label = event.data.locales.sendpm;
                    this.permissionSystem['ingameAction'][17].label = event.data.locales.giveveh;
                    this.permissionSystem['ingameAction'][18].label = event.data.locales.givevehicletodatabase;
                    this.permissionSystem['ingameAction'][19].label = event.data.locales.showcoords;
                    this.permissionSystem['ingameAction'][20].label = event.data.locales.clothingmenu;
                    this.permissionSystem['ingameAction'][21].label = event.data.locales.takepicture;
                    this.permissionSystem['ingameAction'][22].label = event.data.locales.clearinv;
                    this.permissionSystem['ingameAction'][23].label = event.data.locales.setjob;
                    this.permissionSystem['ingameAction'][24].label = event.data.locales.repairvehicle;
                    this.permissionSystem['ingameAction'][25].label = event.data.locales.teleportmarker;
                    this.permissionSystem['ingameAction'][26].label = event.data.locales.givestaff;
                    this.permissionSystem['ingameAction'][27].label = event.data.locales.staffChat;


                    this.permissionSystem['serverAction'][0].label = event.data.locales.clearvehicle;
                    this.permissionSystem['serverAction'][1].label = event.data.locales.allrevive;
                    this.permissionSystem['serverAction'][2].label = event.data.locales.cleararea;
                    this.permissionSystem['serverAction'][3].label = event.data.locales.logweatherchange;
                    this.permissionSystem['serverAction'][4].label = event.data.locales.changeTime;
                    this.permissionSystem['serverAction'][5].label = event.data.locales.unban;
                    this.permissionSystem['serverAction'][6].label = event.data.locales.announce;
                    this.permissionSystem['serverAction'][7].label = event.data.locales.logsetfreezetime;
                    this.permissionSystem['serverAction'][8].label = event.data.locales.runcmd;
                    this.permissionSystem['serverAction'][9].label = event.data.locales.unjail;
                   break;
                case "adminchat":
                    this.adminChatData = event.data.adminChat;
                    if (this.stafMenuPage == 'main') {
                        this.$nextTick(() => {
                            var container = document.getElementById("adminchatContainer");
                            container.scrollTop = container.scrollHeight;
                        });
                    }
                break;
                case  "updatePermission":
                    
                    if (event.data.value && this.playerSelect) {

                        let playerIndex = this.filterScoreBoardData.findIndex(player => parseInt(player.id) == parseInt(event.data.value.id));
                        if (playerIndex != -1) {
                        
                             this.filterScoreBoardData[playerIndex] = event.data.value;
                             if(parseInt(this.playerSelect.id) == parseInt(event.data.value.id)){
                                 this.playerSelect = event.data.value
                             
                              
                             }
                      
                             if (this.selfStaffData && this.selfStaffData.id == this.filterScoreBoardData[playerIndex].id) {
                                 this.selfStaffData = event.data.value;
                            
                             }
                        }
                        let playerIndex2 = this.scoreBoardData.findIndex(player => parseInt(player.id) == parseInt(event.data.value.id));
                        if (playerIndex2 != -1) {
                        
                             this.scoreBoardData[playerIndex] = event.data.value;
                 
                        }
                    } else {
                        if(event.data.value){
                        
                            this.playerSelect = event.data.value;

                            let playerIndex = this.filterScoreBoardData.findIndex(player => parseInt(player.id) == parseInt(event.data.value.id));
                            if (playerIndex != -1) {
                                this.filterScoreBoardData[playerIndex] = event.data.value;
                                this.checkPlayerPermissionChangeTable(this.playerSelect.rankname)
                                if (this.selfStaffData && this.selfStaffData.id == this.filterScoreBoardData[playerIndex].id) {
                                    this.selfStaffData = event.data.value;
    
                                }
                                this.playerSelect = false;
                                this.playerStateAttributeValue = false;
                            }
                            let playerIndex2 = this.scoreBoardData.findIndex(player => parseInt(player.id) == parseInt(event.data.value.id));
                            if (playerIndex2 != -1) {
                            
                                 this.scoreBoardData[playerIndex] = event.data.value;
                     
                            }
                        }else{
                            this.playerSelect = false;
                            this.playerStateAttributeValue = false;
                        }
                       
                      
                    }
                    
                break;
                case "updatePlayerSelf":
                    
                    if (event.data.value && this.playerSelect) {

                        let playerIndex = this.filterScoreBoardData.findIndex(player => parseInt(player.id) == parseInt(event.data.value.id));
                        if (playerIndex != -1) {
                        
                             this.filterScoreBoardData[playerIndex] = event.data.value;
                             if(parseInt(this.playerSelect.id) == parseInt(event.data.value.id)){
                                 this.playerSelect = event.data.value
                             
                              
                             }
                             this.checkPlayerPermissionChangeTable(event.data.value.rankname)
                             if (this.selfStaffData && this.selfStaffData.id == this.filterScoreBoardData[playerIndex].id) {
                                 this.selfStaffData = event.data.value;
                            
                             }
                        }
                        let playerIndex2 = this.scoreBoardData.findIndex(player => parseInt(player.id) == parseInt(event.data.value.id));
                        if (playerIndex2 != -1) {
                        
                             this.scoreBoardData[playerIndex] = event.data.value;
                 
                        }
                    } else {
                        if(event.data.value){
                        
                            this.playerSelect = event.data.value;

                            let playerIndex = this.filterScoreBoardData.findIndex(player => parseInt(player.id) == parseInt(event.data.value.id));
                            if (playerIndex != -1) {
                                this.filterScoreBoardData[playerIndex] = event.data.value;
                                this.checkPlayerPermissionChangeTable(this.playerSelect.rankname)
                                if (this.selfStaffData && this.selfStaffData.id == this.filterScoreBoardData[playerIndex].id) {
                                    this.selfStaffData = event.data.value;
    
                                }
                                this.playerSelect = false;
                                this.playerStateAttributeValue = false;
                            }
                            let playerIndex2 = this.scoreBoardData.findIndex(player => parseInt(player.id) == parseInt(event.data.value.id));
                            if (playerIndex2 != -1) {
                            
                                 this.scoreBoardData[playerIndex] = event.data.value;
                     
                            }
                        }else{
                            this.playerSelect = false;
                            this.playerStateAttributeValue = false;
                        }
                       
                      
                    }
                    break;

                case "removePlayerSelf":
               
                    if (event.data.value && this.playerSelect) {
                      
                        let playerIndex = this.filterScoreBoardData.findIndex(player => parseInt(player.id) == parseInt(event.data.value.id));
                        if (playerIndex != -1) {
                            if(this.playerSelect.id == event.data.value.id){
                                this.playerSelect= false
                                this.playerStateAttributeValue = false;
                            }   
                            this.filterScoreBoardData.splice(playerIndex, 1);
                        }else{
                            console.log("PLACE CONTACT CODEM", JSON.stringify(event.data.value))
                        }
                     
                      
                        
                        if (this.spectateMenu) {
                            this.spectateModel = false;
                            this.spectateModelLet = false;
                            setTimeout(() => {
                                this.spectateMenu = false;
                            }, 100);
                            setTimeout(() => {
                                this.stafMenuPage = "main";
                            }, 1200);
                        }

                    }else{
                        if(event.data.value){
                            let playerIndex = this.filterScoreBoardData.findIndex(player => parseInt(player.id) == parseInt(event.data.value.id));
                            if (playerIndex != -1) {
                                this.filterScoreBoardData.splice(playerIndex, 1);
                            }
                        }
                   
                    }

                    break;
                case "spectatePlayer":
                    this.stafMenuPage = false;
                    setTimeout(() => {
                        this.stafMenuPage = "spectating";
                    }, 1000);
                    setTimeout(() => {
                        this.spectateMenu = true;
                    }, 1200);
                    break;
                case "notifyMessage":
                    if (this.playerSelect) {
                        this.forCopiedDiscordEtc = event.data.message

                        setTimeout(() => {
                            this.forCopiedDiscordEtc = false;
                        }, 1500);
                    } else {
                        this.forCopiedDiscordEtcAlt = event.data.message

                        setTimeout(() => {
                            this.forCopiedDiscordEtcAlt = false;
                        }, 1500);
                    }

                    break;
                case "openDevtoolsMenu":
                    this.stafMenuPage = false;
                    setTimeout(() => {
                        this.stafMenuPage = "devtools";

                    }, 1000);
                    setTimeout(() => {
                        this.devtoolsMenuValue = true;
                        this.checkedStatus['showmouse'] = true;
                    }, 1200);
                    break;
                case "showWarn":
                    clicksound('notification')
                    this.notification(event.data.message, 'warn')
                    break;
                case "showPm":
                    clicksound('notification')
                    this.notification(event.data.message, 'pm')
                    break;
                case "showAnnounce":
                    clicksound('notification')
                    this.notification(event.data.message, 'announce')
                    break;
                case "showJailTime":
                    clicksound('notification')
                    this.notification(event.data.message, 'jailtime')
                    break;
                case "allDataBaseData":
                    this.allDataBaseData = event.data.data;

                    break;
                case "refreshAllData":
                    this.allDataBaseData = event.data.data;
                    if (!this.bannedButton) return;
                    let BannedData = [];
                    for (let key in this.allDataBaseData) {
                        if (this.allDataBaseData[key].banned === 1) {
                            BannedData.push({
                                image: {
                                    image: 'scoreboardbanned'
                                },
                                id: 0,
                                name: this.allDataBaseData[key].name,
                                identifier: this.allDataBaseData[key].identifier,
                            })
                        }
                    }

                    this.filterScoreBoardData = BannedData;

                    break;
                case "showCoords":

                    this.showCoords = event.data.coords;
                    break;
                case "showMouse":

                    this.checkedStatus['showmouse'] = event.data.value;
                    break;
                case "copyvector3":
                    staffClipToBoard(event.data.value)
                    break;
                case "copyvector4":
                    staffClipToBoard(event.data.value)
                    break;
                case "staffForOpenCloseMenu":
                    this.backToStatePage();
                    this.stafMenuPage = false;
                    postNUI("closeAdminMenu");
                break;

                // version 1.5.0
                case "playermoneyData":
                    if(event.data.moneyData){
                        this.moneyData = event.data.moneyData;
                        for(let player in event.data.moneyData){
                    
                            this.totalMoney += event.data.moneyData[player].totalmoney;
                            this.totalBank += event.data.moneyData[player].totalbank;
                        }
                        this.mainSettings[1].value = this.totalMoney+ '$';
                        this.mainSettings[2].value = this.totalBank + '$';
                        this.mainSettings[0].value = this.scoreBoardData.length;
                   
                    }
                break;
                
                case "banneddata":

                     this.filterScoreBoardData = event.data.data;
                break;

                case "onlineAdmins":
                    this.onlineStaff = event.data.onlineAdmin
                break;
                case "copyIdentifier":

                    staffClipToBoard(event.data.value)
                break;

                // case "deleteMoneyData":
                //     if(event.data.identifier){
                //         if(this.moneyData[event.data.identifier]){
                //             this.moneyData[event.data.identifier].totalmoney = 0;
                //             this.moneyData[event.data.identifier].totalbank = 0;

                //             this.totalMoney = 0;
                //             this.totalBank = 0;
                //             for(let player in this.moneyData){
                //                 this.totalMoney += this.moneyData[player].totalmoney;
                //                 this.totalBank += this.moneyData[player].totalbank;
                //             }
                //             this.mainSettings[1].value = this.totalMoney+ '$';
                //             this.mainSettings[2].value = this.totalBank + '$';
                //         }
                //     }

                // break;

                default:
                break;
            }
        });

    }
});

app.use(store).mount("#app");

function clicksound(val) {
    let audioPath = "./sound/" + val + ".ogg";
    audioPlayer = new Howl({
        src: [audioPath]
    });
    audioPlayer.volume(0.4);
    audioPlayer.play();
}

var resourceName = "codem-staff";

if (window.GetParentResourceName) {
    resourceName = window.GetParentResourceName();
}

window.postNUI = async (name, data) => {
    try {
        const response = await fetch(`https://${resourceName}/${name}`, {
            method: "POST",
            mode: "cors",
            cache: "no-cache",
            credentials: "same-origin",
            headers: {
                "Content-Type": "application/json"
            },
            redirect: "follow",
            referrerPolicy: "no-referrer",
            body: JSON.stringify(data)
        });
        return !response.ok ? null : response.json();
    } catch (error) {
        // console.log(error)
    }
};

const staffClipToBoard = str => {
    const el = document.createElement("textarea");
    el.value = str;
    document.body.appendChild(el);
    el.select();
    document.execCommand("copy");
    document.body.removeChild(el);
};

$(document).on("focusout", "input", () => {
    
    postNUI('OnInputFocusRemove')
})

$(document).on("focusin", "input", () => {
    postNUI('OnInputFocus')
})

$(document).on("focusout", "textarea", () => {
    postNUI('OnInputFocusRemove')
})

$(document).on("focusin", "textarea", () => {
    postNUI('OnInputFocus')
})