import { DataTypes, Model } from 'sequelize';
import sequelize from '../config/db';
import { IUser } from '../types';

class User extends Model<IUser> implements IUser {
  id?: string;
  nome!: string;
  email!: string;
  senha!: string;
  fotoPerfil?: string;
  verificationCode?: string;
  codeExpires?: number | null;
}

User.init(
  {
    id: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4,
      primaryKey: true,
    },
    nome: { type: DataTypes.STRING, allowNull: false },
    email: { type: DataTypes.STRING, allowNull: false, unique: true },
    senha: { type: DataTypes.STRING, allowNull: false },
    fotoPerfil: { type: DataTypes.STRING },
    verificationCode: { type: DataTypes.STRING },
    codeExpires: { type: DataTypes.BIGINT },
  },
  {
    sequelize,
    timestamps: true,
    modelName: 'User',
  }
);

export default User;
